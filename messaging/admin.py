from django.contrib import admin
from django.utils.html import format_html
from .models import Message


@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display    = ('expediteur', 'destinataire', 'contenu_short', 'date_envoi', 'lu_badge')
    list_filter     = ('lu',)
    search_fields   = ('expediteur__username', 'destinataire__username', 'contenu')
    ordering        = ('-date_envoi',)
    list_per_page   = 30
    readonly_fields = ('date_envoi',)
    raw_id_fields   = ('expediteur', 'destinataire')
    date_hierarchy  = 'date_envoi'

    fieldsets = (
        ('Message', {
            'fields': ('expediteur', 'destinataire', 'contenu', 'lu')
        }),
        ('Métadonnées', {
            'fields': ('date_envoi',),
            'classes': ('collapse',),
        }),
    )

    def contenu_short(self, obj):
        if len(obj.contenu) > 60:
            return obj.contenu[:60] + '...'
        return obj.contenu
    contenu_short.short_description = 'Message'

    def lu_badge(self, obj):
        if obj.lu:
            return format_html('<span style="color:#198754">✓ Lu</span>')
        return format_html('<span style="color:#ffc107;font-weight:bold">● Non lu</span>')
    lu_badge.short_description = 'Statut'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('expediteur', 'destinataire')