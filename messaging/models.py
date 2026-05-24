from django.db import models
from users.models import Users


class Message(models.Model):
    expediteur   = models.ForeignKey(
        Users, on_delete=models.CASCADE, related_name='sent_messages'
    )
    destinataire = models.ForeignKey(
        Users, on_delete=models.CASCADE, related_name='received_messages'
    )
    contenu    = models.TextField()
    date_envoi = models.DateTimeField(auto_now_add=True)
    lu         = models.BooleanField(default=False)

    class Meta:
        verbose_name        = 'Message'
        verbose_name_plural = 'Messages'
        ordering            = ['-date_envoi']
        # KEY FIX: SQL inserts into notifications_message
        # but this app is called 'messages' so Django would
        # create messages_message — force it to use notifications_message
        db_table = 'notifications_message'

    def __str__(self):
        return f'{self.expediteur.username} → {self.destinataire.username}'