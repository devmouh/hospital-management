from rest_framework import serializers
from .models import Document


class DocumentSerializer(serializers.ModelSerializer):
    type_doc_display = serializers.CharField(source='get_type_doc_display', read_only=True)

    class Meta:
        model  = Document
        fields = [
            'id', 'patient', 'consultation',
            'nom_fichier', 'type_doc', 'type_doc_display',
            'fichier', 'url_stockage', 'date_upload',
            # uploaded_by is set server-side via serializer.save(uploaded_by=request.user)
            # it is intentionally not writable by the client
        ]
        read_only_fields = ['id', 'date_upload', 'type_doc_display']