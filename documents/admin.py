from django.contrib import admin
from django.utils.html import format_html
from .models import Document


@admin.register(Document)
class DocumentAdmin(admin.ModelAdmin):
    list_display    = ('nom_fichier', 'type_badge', 'patient_name', 'consultation_date', 'date_upload', 'fichier_link')
    list_filter     = ('type_doc',)
    search_fields   = ('nom_fichier', 'patient__first_name', 'patient__last_name')
    ordering        = ('-date_upload',)
    list_per_page   = 25
    readonly_fields = ('date_upload',)
    raw_id_fields   = ('patient', 'consultation')
    date_hierarchy  = 'date_upload'

    fieldsets = (
        ('Document', {
            'fields': ('patient', 'consultation', 'nom_fichier', 'type_doc', 'fichier')
        }),
        ('Métadonnées', {
            'fields': ('date_upload',),
            'classes': ('collapse',),
        }),
    )

    def patient_name(self, obj):
        return f"{obj.patient.first_name} {obj.patient.last_name}"
    patient_name.short_description = 'Patient'
    patient_name.admin_order_field = 'patient__last_name'

    def consultation_date(self, obj):
        if obj.consultation:
            return obj.consultation.date_consultation.strftime('%d/%m/%Y')
        return '—'
    consultation_date.short_description = 'Consultation'

    def type_badge(self, obj):
        colors = {
            'ORDONNANCE':   '#0d6efd',
            'RADIO':        '#fd7e14',
            'ANALYSE':      '#198754',
            'COMPTE_RENDU': '#6610f2',
            'AUTRE':        '#6c757d',
        }
        color = colors.get(obj.type_doc, '#6c757d')
        return format_html(
            '<span style="background:{};color:#fff;padding:2px 8px;border-radius:4px;font-size:11px">{}</span>',
            color, obj.get_type_doc_display()
        )
    type_badge.short_description = 'Type'

    def fichier_link(self, obj):
        if obj.fichier:
            return format_html('<a href="{}" target="_blank">📄 Ouvrir</a>', obj.fichier.url)
        return '—'
    fichier_link.short_description = 'Fichier'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related(
            'patient', 'consultation'
        )