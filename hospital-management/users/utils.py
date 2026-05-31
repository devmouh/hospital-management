from django.core.mail import send_mail
from django.conf import settings


def send_email(email, token):
    subject = 'Réinitialisation de mot de passe'
    message = f'Cliquez sur ce lien pour réinitialiser votre mot de passe: http://localhost:8000/reset/{token}/'
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [email]
    send_mail(subject, message, email_from, recipient_list)
    return True