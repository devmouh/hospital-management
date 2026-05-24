from django.db.models import Q
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Message
from .serializers import MessageSerializer, SendMessageSerializer


class InboxView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        messages = Message.objects.filter(destinataire=request.user)
        return Response(MessageSerializer(messages, many=True).data)


class SentView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        messages = Message.objects.filter(expediteur=request.user)
        return Response(MessageSerializer(messages, many=True).data)


class SendMessageView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = SendMessageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(expediteur=request.user)
            return Response(serializer.data, status=201)
        return Response(serializer.errors, status=400)


class ConversationView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, user_id):
        messages = Message.objects.filter(
            Q(expediteur=request.user,   destinataire_id=user_id) |
            Q(expediteur_id=user_id, destinataire=request.user)
        ).order_by('date_envoi')
        messages.filter(destinataire=request.user, lu=False).update(lu=True)
        return Response(MessageSerializer(messages, many=True).data)


class UnreadCountView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        count = Message.objects.filter(destinataire=request.user, lu=False).count()
        return Response({'unread_count': count})


class MarkAsReadView(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request, pk):
        try:
            message = Message.objects.get(pk=pk, destinataire=request.user)
        except Message.DoesNotExist:
            return Response({'detail': 'Not found.'}, status=404)
        message.lu = True
        message.save(update_fields=['lu'])
        return Response({'detail': 'Message marqué comme lu.'})


class DeleteMessageView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, pk):
        try:
            message = Message.objects.get(
                Q(expediteur=request.user) | Q(destinataire=request.user),
                pk=pk,
            )
        except Message.DoesNotExist:
            return Response({'detail': 'Not found or not allowed.'}, status=404)
        message.delete()
        return Response({'detail': 'Message supprimé.'}, status=204)