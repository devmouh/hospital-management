from .models import Notification


def create_notification(user, type_notif, contenu, title='', appointment=None):
    TYPE_MAP = {
        'RDV':     'REMINDER',
        'RESULT':  'RESULT',
        'MESSAGE': 'MESSAGE',
    }
    notif_type = TYPE_MAP.get(type_notif, 'MESSAGE')

    Notification.objects.create(
        recipient=user,
        notif_type=notif_type,
        title=title or _default_title(notif_type),
        message=contenu,
        appointment=appointment,
    )


def _default_title(notif_type):
    return {
        'REMINDER':  'Rappel de rendez-vous',
        'RESULT':    'Résultat disponible',
        'MESSAGE':   'Nouveau message',
        'ADMISSION': 'Admission hospitalière',
        'DISCHARGE': 'Sortie hospitalière',
    }.get(notif_type, 'Notification')