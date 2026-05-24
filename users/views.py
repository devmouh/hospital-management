from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model
from django.utils import timezone

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.exceptions import TokenError

from .serializers import UserSerializer, UserUpdateSerializer

User = get_user_model()


def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access':  str(refresh.access_token),
    }


# ─── Login ────────────────────────────────────────────────────────────────────

class LoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.data.get('username', '').strip()
        password = request.data.get('password', '')

        if not username or not password:
            return Response(
                {'detail': 'Veuillez remplir tous les champs.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        user = authenticate(request, username=username, password=password)

        if not user:
            return Response(
                {'detail': "Nom d'utilisateur ou mot de passe incorrect."},
                status=status.HTTP_401_UNAUTHORIZED
            )

        if not user.is_active:
            return Response(
                {'detail': 'Ce compte est désactivé.'},
                status=status.HTTP_403_FORBIDDEN
            )

        tokens = get_tokens_for_user(user)
        return Response({
            'tokens': tokens,
            'user': {
                'id':         user.id,
                'username':   user.username,
                'email':      user.email,
                'first_name': user.first_name,
                'last_name':  user.last_name,
                'role':       user.role,
            }
        }, status=status.HTTP_200_OK)


# ─── Logout ───────────────────────────────────────────────────────────────────

class LogoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        refresh_token = request.data.get('refresh')
        if not refresh_token:
            return Response(
                {'detail': 'Refresh token requis.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        try:
            token = RefreshToken(refresh_token)
            token.blacklist()
        except TokenError:
            return Response(
                {'detail': 'Token invalide ou déjà révoqué.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        return Response({'detail': 'Déconnexion réussie.'}, status=status.HTTP_200_OK)


# ─── Profile ──────────────────────────────────────────────────────────────────

class ProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return Response(UserSerializer(request.user).data)

    def patch(self, request):
        serializer = UserUpdateSerializer(
            request.user,
            data=request.data,
            partial=True,
        )
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        serializer.save()
        return Response({'detail': 'Profil mis à jour avec succès.'})


# ─── Password Reset ───────────────────────────────────────────────────────────

class PasswordResetRequestView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        import uuid
        from datetime import timedelta
        from .models import Reste_token
        from .utils import send_email

        email = request.data.get('email', '').strip()
        # Always return 200 — never reveal whether email exists
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({'detail': 'Si cet email existe, un lien a été envoyé.'})

        token = uuid.uuid4().hex
        Reste_token.objects.create(
            user=user,
            token=token,
            expires_at=timezone.now() + timedelta(hours=1)
        )
        send_email(user.email, token)
        return Response({'detail': 'Si cet email existe, un lien a été envoyé.'})


class PasswordResetConfirmView(APIView):
    permission_classes = [AllowAny]

    def post(self, request, token):
        from .models import Reste_token

        new_password = request.data.get('new_password', '').strip()
        if len(new_password) < 8:
            return Response(
                {'detail': 'Le mot de passe doit contenir au moins 8 caractères.'},
                status=status.HTTP_400_BAD_REQUEST
            )
        try:
            reset = Reste_token.objects.get(token=token)
        except Reste_token.DoesNotExist:
            return Response(
                {'detail': 'Token invalide.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        if reset.expires_at and reset.expires_at < timezone.now():
            reset.delete()
            return Response(
                {'detail': 'Token expiré.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        reset.user.set_password(new_password)
        reset.user.save()
        reset.delete()
        return Response({'detail': 'Mot de passe réinitialisé avec succès.'})