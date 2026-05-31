from django.db import models
from users.models import Patients, Users


class Document(models.Model):
    TYPE_CHOICES = (
        ('ORDONNANCE',   'Ordonnance'),
        ('RADIO',        'Radiographie'),
        ('ANALYSE',      'Analyse de laboratoire'),
        ('EXAMEN',       'Examen complémentaire'),  # NEW — SQL uses 'EXAMEN'
        ('COMPTE_RENDU', 'Compte rendu'),
        ('AUTRE',        'Autre'),
    )

    patient      = models.ForeignKey(
        Patients, on_delete=models.CASCADE, related_name='documents'
    )
    consultation = models.ForeignKey(
        'consultations.Consultation',
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name='documents'
    )
    # NEW — SQL stores who uploaded (doctor or secretary)
    uploaded_by  = models.ForeignKey(
        Users,
        on_delete=models.SET_NULL,
        null=True, blank=True,
        related_name='uploaded_documents'
    )
    nom_fichier  = models.CharField(max_length=255)
    type_doc     = models.CharField(max_length=20, choices=TYPE_CHOICES, default='AUTRE')
    # NEW — SQL stores file path as url_stockage
    url_stockage = models.CharField(max_length=500, blank=True)
    fichier      = models.FileField(upload_to='documents/%Y/%m/', null=True, blank=True)
    date_upload  = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name        = 'Document'
        verbose_name_plural = 'Documents'
        ordering            = ['-date_upload']

    def __str__(self):
        return f'{self.nom_fichier} — {self.patient}'