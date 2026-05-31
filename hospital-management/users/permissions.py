from rest_framework.permissions import BasePermission


class IsAdmin(BasePermission):
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role == 'ADMIN'
        )


class IsDoctor(BasePermission):
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role == 'DOCTOR'
        )


class IsParent(BasePermission):
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role == 'PARENT'
        )


class IsSecretaire(BasePermission):  # NEW
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role == 'SECRETAIRE'
        )


class IsAdminOrDoctor(BasePermission):
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role in ('ADMIN', 'DOCTOR')
        )


class IsAdminOrSecretaire(BasePermission):  # NEW
    """Admin or secretary — both can manage appointments"""
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role in ('ADMIN', 'SECRETAIRE')
        )


class IsAdminOrDoctorOrSecretaire(BasePermission):  # NEW
    """All hospital staff"""
    def has_permission(self, request, view):
        return bool(
            request.user and request.user.is_authenticated
            and request.user.role in ('ADMIN', 'DOCTOR', 'SECRETAIRE')
        )