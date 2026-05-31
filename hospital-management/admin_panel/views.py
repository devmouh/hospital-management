from django.shortcuts import get_object_or_404
from django.db.models import Count, Q
from django.utils.dateparse import parse_datetime
from datetime import timedelta

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from users.models import Users, Doctors, Patients, TraceAction
from consultations.models import Appointment
from users.permissions import IsAdmin
from .serializers import (
    AdminUserSerializer, AdminUserCreateSerializer,
    AdminDoctorSerializer, AdminDoctorCreateSerializer,
    AdminPatientSerializer, AdminAppointmentSerializer,
)


def _log(user, action, table=""):
    TraceAction.objects.create(user=user, action=action, table_concernee=table)


# ─── Permission ───────────────────────────────────────────────────────────────

class IsAdminOrSecretaire(IsAuthenticated):
    """Allows access to ADMIN and SECRETAIRE roles."""
    def has_permission(self, request, view):
        if not super().has_permission(request, view):
            return False
        return getattr(request.user, 'role', '') in ('ADMIN', 'SECRETAIRE')


# ─── Dashboard ────────────────────────────────────────────────────────────────

class AdminDashboardView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        total_doctors      = Doctors.objects.filter(actif=True).count()
        total_patients     = Patients.objects.count()
        total_parents      = Users.objects.filter(role='PARENT').count()
        total_appointments = Appointment.objects.count()

        appointments_by_status = {
            'pending':   Appointment.objects.filter(status='PENDING').count(),
            'confirmed': Appointment.objects.filter(status='CONFIRMED').count(),
            'completed': Appointment.objects.filter(status='COMPLETED').count(),
            'cancelled': Appointment.objects.filter(status='CANCELLED').count(),
        }

        recent_appointments = (
            Appointment.objects
            .select_related('doctor__user', 'patient')
            .order_by('-created_at')[:5]
        )

        return Response({
            'stats': {
                'total_doctors':      total_doctors,
                'total_patients':     total_patients,
                'total_parents':      total_parents,
                'total_appointments': total_appointments,
            },
            'appointments_by_status': appointments_by_status,
            'recent_appointments': AdminAppointmentSerializer(recent_appointments, many=True).data,
        })


# ─── Users ────────────────────────────────────────────────────────────────────

class AdminUserListView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        users = Users.objects.all().order_by('-date_joined')
        role   = request.query_params.get('role', '').strip()
        search = request.query_params.get('search', '').strip()
        active = request.query_params.get('active', '').strip()
        if role:
            users = users.filter(role=role)
        if search:
            users = users.filter(
                Q(first_name__icontains=search) |
                Q(last_name__icontains=search)  |
                Q(email__icontains=search)       |
                Q(username__icontains=search)
            )
        if active in ('true', 'false'):
            users = users.filter(is_active=(active == 'true'))
        return Response(AdminUserSerializer(users, many=True).data)

    def post(self, request):
        serializer = AdminUserCreateSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        user = serializer.save()
        _log(request.user, 'CREATE_USER', 'Users')
        return Response(AdminUserSerializer(user).data, status=status.HTTP_201_CREATED)


class AdminUserDetailView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request, user_id):
        user = get_object_or_404(Users, id=user_id)
        return Response(AdminUserSerializer(user).data)

    def patch(self, request, user_id):
        user = get_object_or_404(Users, id=user_id)
        serializer = AdminUserSerializer(user, data=request.data, partial=True)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        serializer.save()
        _log(request.user, 'UPDATE_USER', 'Users')
        return Response(serializer.data)

    def delete(self, request, user_id):
        user = get_object_or_404(Users, id=user_id)
        if user == request.user:
            return Response(
                {'detail': 'Vous ne pouvez pas supprimer votre propre compte.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        user.delete()
        _log(request.user, 'DELETE_USER', 'Users')
        return Response(status=status.HTTP_204_NO_CONTENT)


class AdminUserToggleActiveView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def patch(self, request, user_id):
        user = get_object_or_404(Users, id=user_id)
        if user == request.user:
            return Response(
                {'detail': 'Vous ne pouvez pas désactiver votre propre compte.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        user.is_active = not user.is_active
        user.save()
        state = 'activé' if user.is_active else 'désactivé'
        _log(request.user, f'USER_{state.upper()}', 'Users')
        return Response({'detail': f'Compte {state}.', 'is_active': user.is_active})


# ─── Doctors ──────────────────────────────────────────────────────────────────

class AdminDoctorListView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        doctors = Doctors.objects.select_related('user', 'specialty').all()
        search    = request.query_params.get('search', '').strip()
        specialty = request.query_params.get('specialty', '').strip()
        actif     = request.query_params.get('actif', '').strip()
        if search:
            doctors = doctors.filter(
                Q(user__first_name__icontains=search) |
                Q(user__last_name__icontains=search)
            )
        if specialty:
            doctors = doctors.filter(specialty__name__icontains=specialty)
        if actif in ('true', 'false'):
            doctors = doctors.filter(actif=(actif == 'true'))
        return Response(AdminDoctorSerializer(doctors, many=True).data)

    def post(self, request):
        serializer = AdminDoctorCreateSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        doctor = serializer.save()
        _log(request.user, 'CREATE_DOCTOR', 'Doctors')
        return Response(AdminDoctorSerializer(doctor).data, status=status.HTTP_201_CREATED)


class AdminDoctorDetailView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request, doctor_id):
        doctor = get_object_or_404(Doctors, id=doctor_id)
        return Response(AdminDoctorSerializer(doctor).data)

    def patch(self, request, doctor_id):
        doctor = get_object_or_404(Doctors, id=doctor_id)
        data   = request.data
        user   = doctor.user
        if 'first_name'  in data: user.first_name = data['first_name'].strip()
        if 'last_name'   in data: user.last_name  = data['last_name'].strip()
        if 'phone'       in data: user.phone      = data['phone'].strip()
        if 'email'       in data: user.email      = data['email'].strip()
        user.save()
        if 'bio'           in data: doctor.bio           = data['bio']
        if 'ville'         in data: doctor.ville         = data['ville']
        if 'horaire_travail' in data: doctor.horaire_travail = data['horaire_travail']
        if 'actif'         in data: doctor.actif         = data['actif']
        if 'specialty_id'  in data:
            from users.models import Specialty
            doctor.specialty = get_object_or_404(Specialty, id=data['specialty_id'])
        doctor.save()
        _log(request.user, 'UPDATE_DOCTOR', 'Doctors')
        return Response(AdminDoctorSerializer(doctor).data)

    def delete(self, request, doctor_id):
        doctor = get_object_or_404(Doctors, id=doctor_id)
        doctor.user.delete()
        _log(request.user, 'DELETE_DOCTOR', 'Doctors')
        return Response(status=status.HTTP_204_NO_CONTENT)


class AdminDoctorToggleActiveView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def patch(self, request, doctor_id):
        doctor       = get_object_or_404(Doctors, id=doctor_id)
        doctor.actif = not doctor.actif
        doctor.save()
        state = 'activé' if doctor.actif else 'désactivé'
        _log(request.user, f'DOCTOR_{state.upper()}', 'Doctors')
        return Response({'detail': f'Médecin {state}.', 'actif': doctor.actif})


# ─── Patients ─────────────────────────────────────────────────────────────────

class AdminPatientListView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        patients = Patients.objects.select_related('parent').all()
        search = request.query_params.get('search', '').strip()
        if search:
            patients = patients.filter(
                Q(first_name__icontains=search) |
                Q(last_name__icontains=search)
            )
        return Response(AdminPatientSerializer(patients, many=True).data)


class AdminPatientDetailView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request, patient_id):
        patient = get_object_or_404(Patients, id=patient_id)
        return Response(AdminPatientSerializer(patient).data)


# ─── Appointments ─────────────────────────────────────────────────────────────

class AdminAppointmentListView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request):
        appointments = (
            Appointment.objects
            .select_related('doctor__user', 'patient')
            .order_by('-date_rdv')
        )
        status_filter = request.query_params.get('status', '').strip()
        date_filter   = request.query_params.get('date', '').strip()
        doctor_name   = request.query_params.get('doctor_name', '').strip()
        patient_name  = request.query_params.get('patient_name', '').strip()
        if status_filter and status_filter != 'All':
            appointments = appointments.filter(status=status_filter)
        if date_filter:
            appointments = appointments.filter(date_rdv__date=date_filter)
        if doctor_name:
            appointments = appointments.filter(
                Q(doctor__user__last_name__icontains=doctor_name) |
                Q(doctor__user__first_name__icontains=doctor_name)
            )
        if patient_name:
            appointments = appointments.filter(
                Q(patient__first_name__icontains=patient_name) |
                Q(patient__last_name__icontains=patient_name)
            )
        return Response({
            'appointments':   AdminAppointmentSerializer(appointments, many=True).data,
            'status_choices': Appointment.STATUS_CHOICES,
        })


class AdminAppointmentDetailView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def get(self, request, appointment_id):
        appointment = get_object_or_404(Appointment, id=appointment_id)
        return Response(AdminAppointmentSerializer(appointment).data)


class AdminAppointmentStatusView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    def patch(self, request, appointment_id):
        appointment = get_object_or_404(Appointment, id=appointment_id)
        new_status  = str(request.data.get('status', '')).strip()
        valid = dict(Appointment.STATUS_CHOICES).keys()
        if new_status not in valid:
            return Response({'detail': 'Statut invalide.'}, status=status.HTTP_400_BAD_REQUEST)
        if appointment.status == 'COMPLETED':
            return Response(
                {'detail': 'Impossible de modifier une consultation terminée.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        appointment.status = new_status
        appointment.save()
        _log(request.user, f'UPDATE_APPOINTMENT_STATUS:{new_status}', 'Appointment')
        return Response({'detail': 'Statut mis à jour.', 'status': new_status})


# ─── SECRETAIRE VIEWS ─────────────────────────────────────────────────────────

class SecretaireDashboardView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def get(self, request):
        from django.utils import timezone
        today = timezone.now().date()
        total_appointments   = Appointment.objects.count()
        today_appointments   = Appointment.objects.filter(date_rdv__date=today).count()
        pending_appointments = Appointment.objects.filter(status='PENDING').count()
        total_patients       = Patients.objects.count()
        total_doctors        = Doctors.objects.filter(actif=True).count()
        recent = (
            Appointment.objects
            .select_related('doctor__user', 'patient')
            .order_by('-date_rdv')[:10]
        )
        today_list = (
            Appointment.objects
            .select_related('doctor__user', 'patient')
            .filter(date_rdv__date=today)
            .order_by('date_rdv')
        )
        return Response({
            'stats': {
                'total_appointments':   total_appointments,
                'today_appointments':   today_appointments,
                'pending_appointments': pending_appointments,
                'total_patients':       total_patients,
                'total_doctors':        total_doctors,
            },
            'recent_appointments': AdminAppointmentSerializer(recent, many=True).data,
            'today_appointments':  AdminAppointmentSerializer(today_list, many=True).data,
        })


class SecretaireAppointmentListView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def get(self, request):
        appointments = (
            Appointment.objects
            .select_related('doctor__user', 'patient')
            .order_by('-date_rdv')
        )
        status_filter = request.query_params.get('status', '').strip()
        date_filter   = request.query_params.get('date', '').strip()
        doctor_name   = request.query_params.get('doctor', '').strip()
        patient_name  = request.query_params.get('patient', '').strip()
        if status_filter and status_filter != 'ALL':
            appointments = appointments.filter(status=status_filter)
        if date_filter:
            appointments = appointments.filter(date_rdv__date=date_filter)
        if doctor_name:
            appointments = appointments.filter(
                Q(doctor__user__last_name__icontains=doctor_name) |
                Q(doctor__user__first_name__icontains=doctor_name)
            )
        if patient_name:
            appointments = appointments.filter(
                Q(patient__first_name__icontains=patient_name) |
                Q(patient__last_name__icontains=patient_name)
            )
        return Response({
            'appointments': AdminAppointmentSerializer(appointments, many=True).data,
            'total': appointments.count(),
        })


class SecretaireAppointmentCreateView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def post(self, request):
        doctor_id  = request.data.get('doctor_id')
        patient_id = request.data.get('patient_id')
        date_rdv   = request.data.get('date_rdv')
        motif      = request.data.get('motif', '')

        if not all([doctor_id, patient_id, date_rdv]):
            return Response(
                {'detail': 'doctor_id, patient_id and date_rdv are required.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        doctor  = get_object_or_404(Doctors,  id=doctor_id)
        patient = get_object_or_404(Patients, id=patient_id)

        parsed_date = parse_datetime(str(date_rdv))
        if not parsed_date:
            return Response(
                {'detail': 'Invalid date format. Use: 2026-06-05T14:00:00'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # ── DUPLICATE CHECK ──────────────────────────────────────────────────
        window_start = parsed_date - timedelta(minutes=30)
        window_end   = parsed_date + timedelta(minutes=30)

        if Appointment.objects.filter(
            doctor=doctor,
            date_rdv__range=(window_start, window_end),
            status__in=('PENDING', 'CONFIRMED')
        ).exists():
            return Response(
                {'detail': f'Dr. {doctor.user.last_name} already has an appointment within 30 minutes of this time. Please choose a different slot.'},
                status=status.HTTP_409_CONFLICT
            )

        if Appointment.objects.filter(
            patient=patient,
            date_rdv__range=(window_start, window_end),
            status__in=('PENDING', 'CONFIRMED')
        ).exists():
            return Response(
                {'detail': f'{patient.first_name} {patient.last_name} already has an appointment within 30 minutes of this time.'},
                status=status.HTTP_409_CONFLICT
            )
        # ────────────────────────────────────────────────────────────────────

        appointment = Appointment.objects.create(
            doctor=doctor,
            patient=patient,
            date_rdv=parsed_date,
            motif=motif,
            status='PENDING',
            created_by=request.user,
        )
        _log(request.user, 'CREATE_APPOINTMENT', 'Appointment')
        return Response(AdminAppointmentSerializer(appointment).data, status=status.HTTP_201_CREATED)


class SecretaireAppointmentCancelView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def patch(self, request, appointment_id):
        appointment = get_object_or_404(Appointment, id=appointment_id)
        if appointment.status == 'COMPLETED':
            return Response(
                {'detail': 'Cannot cancel a completed appointment.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        appointment.status = 'CANCELLED'
        appointment.save()
        _log(request.user, 'CANCEL_APPOINTMENT', 'Appointment')
        return Response({'detail': 'Appointment cancelled.', 'status': 'CANCELLED'})


class SecretaireAppointmentConfirmView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def patch(self, request, appointment_id):
        appointment = get_object_or_404(Appointment, id=appointment_id)
        if appointment.status != 'PENDING':
            return Response(
                {'detail': 'Only PENDING appointments can be confirmed.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        appointment.status = 'CONFIRMED'
        appointment.save()
        _log(request.user, 'CONFIRM_APPOINTMENT', 'Appointment')
        return Response({'detail': 'Appointment confirmed.', 'status': 'CONFIRMED'})


class SecretairePatientListView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def get(self, request):
        patients = Patients.objects.select_related('parent').all()
        search = request.query_params.get('search', '').strip()
        if search:
            patients = patients.filter(
                Q(first_name__icontains=search) | Q(last_name__icontains=search)
            )
        return Response(AdminPatientSerializer(patients, many=True).data)


class SecretaireDoctorListView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def get(self, request):
        doctors = Doctors.objects.select_related('user', 'specialty').filter(actif=True)
        return Response(AdminDoctorSerializer(doctors, many=True).data)


class SecretaireProfileView(APIView):
    permission_classes = [IsAdminOrSecretaire]

    def get(self, request):
        from users.models import Secretaire
        try:
            sec = Secretaire.objects.get(user=request.user)
            return Response({
                'bureau':            sec.bureau,
                'telephone_interne': sec.telephone_interne,
                'horaires_service':  sec.horaires_service,
                'photo':             sec.photo.name if sec.photo else '',
            })
        except Secretaire.DoesNotExist:
            return Response({})