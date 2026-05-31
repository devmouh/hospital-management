from django.contrib import admin
from .models import Notification


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display    = ('recipient', 'notif_type', 'title', 'message_short', 'is_read', 'created_at')
    list_filter     = ('notif_type', 'is_read')
    search_fields   = ('recipient__username', 'title', 'message')
    ordering        = ('-created_at',)
    list_per_page   = 30
    readonly_fields = ('created_at',)
    raw_id_fields   = ('recipient', 'appointment')

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

    def message_short(self, obj):
        if not obj.message:
            return '-'
        return obj.message[:60] + '...' if len(obj.message) > 60 else obj.message
    message_short.short_description = 'Message'

    def get_queryset(self, request):
        return super().get_queryset(request).select_related('recipient', 'appointment')