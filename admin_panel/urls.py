from django.urls import path
from .views import (
    AdminDashboardView,
    AdminUserListView, AdminUserDetailView, AdminUserToggleActiveView,
    AdminDoctorListView, AdminDoctorDetailView, AdminDoctorToggleActiveView,
    AdminPatientListView, AdminPatientDetailView,
    AdminAppointmentListView, AdminAppointmentDetailView, AdminAppointmentStatusView,
    SecretaireDashboardView,
    SecretaireAppointmentListView,
    SecretaireAppointmentCreateView,
    SecretaireAppointmentCancelView,
    SecretaireAppointmentConfirmView,
    SecretairePatientListView,
    SecretaireDoctorListView,
    SecretaireProfileView,
)

urlpatterns = [

    # ── ADMIN ONLY ────────────────────────────────────────────────────────────

    path('dashboard/',                                    AdminDashboardView.as_view(),          name='admin_dashboard'),

    path('users/',                                        AdminUserListView.as_view(),            name='admin_user_list'),
    path('users/<int:user_id>/',                          AdminUserDetailView.as_view(),          name='admin_user_detail'),
    path('users/<int:user_id>/toggle-active/',            AdminUserToggleActiveView.as_view(),    name='admin_user_toggle'),

    path('doctors/',                                      AdminDoctorListView.as_view(),          name='admin_doctor_list'),
    path('doctors/<int:doctor_id>/',                      AdminDoctorDetailView.as_view(),        name='admin_doctor_detail'),
    path('doctors/<int:doctor_id>/toggle-active/',        AdminDoctorToggleActiveView.as_view(),  name='admin_doctor_toggle'),

    path('patients/',                                     AdminPatientListView.as_view(),         name='admin_patient_list'),
    path('patients/<int:patient_id>/',                    AdminPatientDetailView.as_view(),       name='admin_patient_detail'),

    path('appointments/',                                 AdminAppointmentListView.as_view(),     name='admin_appointment_list'),
    path('appointments/<int:appointment_id>/',            AdminAppointmentDetailView.as_view(),   name='admin_appointment_detail'),
    path('appointments/<int:appointment_id>/status/',     AdminAppointmentStatusView.as_view(),   name='admin_appointment_status'),

    # ── SECRETAIRE (also accessible by ADMIN) ────────────────────────────────

    path('sec/dashboard/',                                SecretaireDashboardView.as_view(),          name='sec_dashboard'),
    path('sec/appointments/',                             SecretaireAppointmentListView.as_view(),    name='sec_appointment_list'),
    path('sec/appointments/create/',                      SecretaireAppointmentCreateView.as_view(),  name='sec_appointment_create'),
    path('sec/appointments/<int:appointment_id>/cancel/', SecretaireAppointmentCancelView.as_view(),  name='sec_appointment_cancel'),
    path('sec/appointments/<int:appointment_id>/confirm/',SecretaireAppointmentConfirmView.as_view(), name='sec_appointment_confirm'),
    path('sec/patients/',                                 SecretairePatientListView.as_view(),        name='sec_patient_list'),
    path('sec/doctors/',                                  SecretaireDoctorListView.as_view(),         name='sec_doctor_list'),
    path('sec/profile/',                                  SecretaireProfileView.as_view(),            name='sec_profile'),
]