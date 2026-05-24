from django.contrib import admin
from django.utils.html import format_html
from .models import Allergie, Antecedent


# ─── Allergie ─────────────────────────────────────────────────────────────────

@admin.register(Allergie)
class AllergieAdmin(admin.ModelAdmin):
    list_display  = ('patient_name', 'nom', 'reaction_badge', 'description_short', 'date_detection')
    list_filter   = ('reaction',)
    search_fields = ('nom', 'patient__first_name', 'patient__last_name', 'description')
    ordering      = ('-date_detection',)
    list_per_page = 25
    raw_id_fields = ('patient',)

    fieldsets = (
        ('Patient', {
            'fields': ('patient',)
        }),
        ('Allergie', {
            'fields': ('nom', 'reaction', 'description', 'date_detection')
        }),
    )

    def patient_name(self, obj):
        return f"{obj.patient.first_name} {obj.patient.last_name}"
    patient_name.short_description = 'Patient'
    patient_name.admin_order_field = 'patient__last_name'

    def reaction_badge(self, obj):
        colors = {
            'LEGERE':   '#198754',
            'MODEREE':  '#ffc107',
            'SEVERE':   '#fd7e14',
            'CRITIQUE': '#dc3545',
        }
        color = colors.get(obj.reaction, '#6c757d')
        return format_html(
            '<span style="background:{};color:#fff;padding:2px 8px;border-radius:4px;font-size:11px">{}</span>',
            color, obj.get_reaction_display()
        )
    reaction_badge.short_description = 'Réaction'

    def description_short(self, obj):
        if len(obj.description) > 60:
            return obj.description[:60] + '...'
        return obj.description
    description_short.short_description = 'Description'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('patient')


# ─── Antecedent ───────────────────────────────────────────────────────────────

@admin.register(Antecedent)
class AntecedentAdmin(admin.ModelAdmin):
    list_display  = ('patient_name', 'type_badge', 'description_short', 'date_declaration')
    list_filter   = ('type_antecedent',)
    search_fields = ('description', 'patient__first_name', 'patient__last_name')
    ordering      = ('-date_declaration',)
    list_per_page = 25
    raw_id_fields = ('patient',)

    fieldsets = (
        ('Patient', {
            'fields': ('patient',)
        }),
        ('Antécédent', {
            'fields': ('type_antecedent', 'description', 'date_declaration')
        }),
    )

    def patient_name(self, obj):
        return f"{obj.patient.first_name} {obj.patient.last_name}"
    patient_name.short_description = 'Patient'
    patient_name.admin_order_field = 'patient__last_name'

    def type_badge(self, obj):
        colors = {
            'MEDICAL':      '#0d6efd',
            'CHIRURGICAL':  '#fd7e14',
            'FAMILIAL':     '#6610f2',
            'NEUROLOGIQUE': '#0dcaf0',
            'GENETIQUE':    '#d63384',
            'AUTRE':        '#6c757d',
        }
        color = colors.get(obj.type_antecedent, '#6c757d')
        return format_html(
            '<span style="background:{};color:#fff;padding:2px 8px;border-radius:4px;font-size:11px">{}</span>',
            color, obj.get_type_antecedent_display()
        )
    type_badge.short_description = 'Type'

    def description_short(self, obj):
        if len(obj.description) > 70:
            return obj.description[:70] + '...'
        return obj.description
    description_short.short_description = 'Description'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('patient')