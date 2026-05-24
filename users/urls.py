from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from . import views

urlpatterns = [
    path('auth/login/',                      views.LoginView.as_view(),                name='login'),
    path('auth/logout/',                     views.LogoutView.as_view(),               name='logout'),
    path('auth/token/refresh/',              TokenRefreshView.as_view(),               name='token_refresh'),
    path('auth/password-reset/',             views.PasswordResetRequestView.as_view(), name='password_reset'),
    path('auth/password-reset/<str:token>/', views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('profile/',                         views.ProfileView.as_view(),              name='profile'),
]