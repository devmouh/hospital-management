from django.contrib import admin
from django.utils.html import format_html
from .models import Notification


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display    = ('recipient', 'type_badge', 'title', 'message_short', 'is_read_badge', 'created_at')
    list_filter     = ('notif_type', 'is_read')
    search_fields   = ('recipient__username', 'title', 'message')
    ordering        = ('-created_at',)
    list_per_page   = 30
    readonly_fields = ('created_at',)
    raw_id_fields   = ('recipient', 'appointment')
    date_hierarchy  = 'created_at'

    fieldsets = (
        ('Notification', {
            'fields': ('recipient', 'notif_type', 'title', 'message', 'is_read')
        }),
        ('Référence', {
            'fields': ('appointment',),
            'classes': ('collapse',),
        }),
        ('Métadonnées', {
            'fields': ('created_at',),
            'classes': ('collapse',),
        }),
    )

    def type_badge(self, obj):
        colors = {
            'REMINDER':  '#0d6efd',
            'RESULT':    '#198754',
            'MESSAGE':   '#6610f2',
            'ADMISSION': '#fd7e14',
            'DISCHARGE': '#6c757d',
        }
        color = colors.get(obj.notif_type, '#6c757d')
        return format_html(
            '<span style="background:{};color:#fff;padding:2px 8px;border-radius:4px;font-size:11px">{}</span>',
            color, obj.get_notif_type_display()
        )
    type_badge.short_description = 'Type'

    def message_short(self, obj):
        if len(obj.message) > 60:
            return obj.message[:60] + '...'
        return obj.message
    message_short.short_description = 'Message'

    def is_read_badge(self, obj):
        if obj.is_read:
            return format_html('<span style="color:#198754">✓ Lu</span>')
        return format_html('<span style="color:#ffc107;font-weight:bold">● Non lu</span>')
    is_read_badge.short_description = 'Statut'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('recipient', 'appointment')