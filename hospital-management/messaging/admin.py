from django.contrib import admin
from .models import Message


@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display    = ('expediteur', 'destinataire', 'contenu_short', 'date_envoi', 'lu')
    list_filter     = ('lu',)
    search_fields   = ('expediteur__username', 'destinataire__username', 'contenu')
    ordering        = ('-date_envoi',)
    list_per_page   = 30
    readonly_fields = ('date_envoi',)
    raw_id_fields   = ('expediteur', 'destinataire')

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
        if not obj.contenu:
            return '-'
        return obj.contenu[:60] + '...' if len(obj.contenu) > 60 else obj.contenu
    contenu_short.short_description = 'Message'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('expediteur', 'destinataire')