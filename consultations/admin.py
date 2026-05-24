from django.contrib import admin
from django.utils.html import format_html
from .models import Appointment, Consultation, Diagnostic, Traitement


def is_sec(user):
    return getattr(user, 'role', '') == 'SECRETAIRE'


class DiagnosticInline(admin.TabularInline):
    model  = Diagnostic
    extra  = 0
    fields = ('nom_maladie', 'type_maladie', 'gravite', 'commentaire_medical', 'explication_parent')
    show_change_link = True

    def has_add_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


class TraitementInline(admin.TabularInline):
    model  = Traitement
    extra  = 0
    fields = ('medicament', 'dose', 'duree', 'instructions')
    show_change_link = True

    def has_add_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


class ConsultationInline(admin.StackedInline):
    model   = Consultation
    extra   = 0
    max_num = 1
    fields  = ('poids', 'taille', 'temperature', 'observation', 'date_consultation')
    readonly_fields = ('date_consultation',)
    show_change_link = True

    def has_add_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Appointment)
class AppointmentAdmin(admin.ModelAdmin):
    list_display    = ('patient_name', 'doctor_name', 'date_rdv', 'heure', 'motif', 'status_badge', 'created_by')
    list_filter     = ('status', 'doctor__specialty', 'doctor')
    search_fields   = ('patient__first_name', 'patient__last_name', 'doctor__user__last_name', 'motif')
    ordering        = ('-date_rdv',)
    list_per_page   = 25
    date_hierarchy  = 'date_rdv'
    raw_id_fields   = ('doctor', 'patient', 'created_by')
    inlines         = [ConsultationInline]

    def get_readonly_fields(self, request, obj=None):
        base = ['created_at', 'updated_at']
        # secretaire cannot edit a completed appointment
        if is_sec(request.user) and obj and obj.status == 'COMPLETED':
            return base + ['doctor', 'patient', 'date_rdv', 'heure', 'motif', 'reason', 'status']
        return base

    def get_fieldsets(self, request, obj=None):
        if is_sec(request.user):
            return (
                ('Rendez-vous', {
                    'fields': ('doctor', 'patient', 'date_rdv', 'heure', 'motif', 'status')
                }),
            )
        return (
            ('Rendez-vous', {
                'fields': ('doctor', 'patient', 'date_rdv', 'heure', 'motif', 'reason', 'status')
            }),
            ('Métadonnées', {
                'fields': ('created_by', 'created_at', 'updated_at'),
                'classes': ('collapse',),
            }),
        )

    def has_view_permission(self, request, obj=None):
        return True

    def has_add_permission(self, request):
        return True  # both admin and secretaire can add

    def has_change_permission(self, request, obj=None):
        return True  # both can change

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)  # only admin can delete

    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)

    def patient_name(self, obj):
        return f"{obj.patient.first_name} {obj.patient.last_name}"
    patient_name.short_description = 'Patient'
    patient_name.admin_order_field = 'patient__last_name'

    def doctor_name(self, obj):
        return f"Dr. {obj.doctor.user.last_name}"
    doctor_name.short_description = 'Médecin'
    doctor_name.admin_order_field = 'doctor__user__last_name'

    def status_badge(self, obj):
        colors = {
            'PENDING':   '#ffc107',
            'CONFIRMED': '#0d6efd',
            'COMPLETED': '#198754',
            'CANCELLED': '#dc3545',
        }
        color = colors.get(obj.status, '#6c757d')
        return format_html(
            '<span style="background:{};color:#fff;padding:2px 8px;'
            'border-radius:4px;font-size:11px">{}</span>',
            color, obj.get_status_display()
        )
    status_badge.short_description = 'Statut'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related(
            'patient', 'doctor__user', 'created_by'
        )


@admin.register(Consultation)
class ConsultationAdmin(admin.ModelAdmin):
    list_display    = ('patient_name', 'doctor_name', 'date_consultation', 'poids', 'taille', 'temperature')
    search_fields   = ('appointment__patient__first_name', 'appointment__patient__last_name')
    ordering        = ('-date_consultation',)
    readonly_fields = ('date_consultation',)
    inlines         = [DiagnosticInline, TraitementInline]

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)

    def patient_name(self, obj):
        return f"{obj.appointment.patient.first_name} {obj.appointment.patient.last_name}"
    patient_name.short_description = 'Patient'

    def doctor_name(self, obj):
        return f"Dr. {obj.appointment.doctor.user.last_name}"
    doctor_name.short_description = 'Médecin'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related(
            'appointment__patient', 'appointment__doctor__user'
        )


@admin.register(Diagnostic)
class DiagnosticAdmin(admin.ModelAdmin):
    list_display  = ('nom_maladie', 'type_maladie', 'gravite', 'patient_name')
    list_filter   = ('type_maladie', 'gravite')
    search_fields = ('nom_maladie', 'consultation__appointment__patient__last_name')

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)

    def patient_name(self, obj):
        p = obj.consultation.appointment.patient
        return f"{p.first_name} {p.last_name}"
    patient_name.short_description = 'Patient'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related(
            'consultation__appointment__patient'
        )


@admin.register(Traitement)
class TraitementAdmin(admin.ModelAdmin):
    list_display  = ('medicament', 'dose', 'duree', 'patient_name')
    search_fields = ('medicament', 'consultation__appointment__patient__last_name')

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)

    def patient_name(self, obj):
        p = obj.consultation.appointment.patient
        return f"{p.first_name} {p.last_name}"
    patient_name.short_description = 'Patient'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related(
            'consultation__appointment__patient'
        )