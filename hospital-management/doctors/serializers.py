# All serializers live in consultations/serializers.py — import from there
# to avoid duplication and keep a single source of truth.
from consultations.serializers import (       # noqa: F401
    AppointmentSerializer,
    ConsultationSerializer,
    DiagnosticSerializer,
    TraitementSerializer,
    CompleteConsultationSerializer,
    ConsultationInputSerializer,
    DiagnosticInputSerializer,
    TraitementInputSerializer,
)