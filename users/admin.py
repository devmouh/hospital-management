from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Address, Users, Specialty, Doctors, Secretaire, Patients, Reste_token, TraceAction


def is_sec(user):
    return getattr(user, 'role', '') == 'SECRETAIRE'


@admin.register(Users)
class UsersAdmin(UserAdmin):
    list_display  = ('username', 'email', 'role', 'is_active', 'is_staff', 'date_joined')
    list_filter   = ('role', 'is_active')
    search_fields = ('username', 'email', 'first_name', 'last_name')
    fieldsets     = UserAdmin.fieldsets + (
        ('Informations supplémentaires', {'fields': ('role', 'phone', 'address')}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Informations supplémentaires', {'fields': ('role', 'phone', 'email')}),
    )

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Address)
class AddressAdmin(admin.ModelAdmin):
    list_display  = ('address_line', 'city', 'region', 'code_postal')
    search_fields = ('city', 'region', 'address_line')

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Specialty)
class SpecialtyAdmin(admin.ModelAdmin):
    list_display  = ('name',)
    search_fields = ('name',)

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Doctors)
class DoctorsAdmin(admin.ModelAdmin):
    list_display  = ('user', 'specialty', 'ville', 'actif', 'numero_ordre_medecins')
    list_filter   = ('specialty', 'actif')
    search_fields = ('user__username', 'user__last_name', 'ville')

    def has_view_permission(self, request, obj=None):
        return True  # secretaire can VIEW doctors

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Secretaire)
class SecretaireAdmin(admin.ModelAdmin):
    list_display  = ('user', 'bureau', 'telephone_interne', 'horaires_service')
    search_fields = ('user__username', 'user__last_name')

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Patients)
class PatientsAdmin(admin.ModelAdmin):
    list_display  = ('first_name', 'last_name', 'birth_date', 'gender', 'groupe_sanguin', 'parent')
    list_filter   = ('gender', 'groupe_sanguin')
    search_fields = ('first_name', 'last_name', 'parent__username')

    def has_view_permission(self, request, obj=None):
        return True  # secretaire can VIEW patients

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(Reste_token)
class ResetTokenAdmin(admin.ModelAdmin):
    list_display  = ('user', 'token', 'created_at', 'expires_at')
    search_fields = ('user__username',)

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


@admin.register(TraceAction)
class TraceActionAdmin(admin.ModelAdmin):
    list_display    = ('user', 'action', 'table_concernee', 'id_enregistrement', 'timestamp')
    list_filter     = ('action', 'table_concernee')
    search_fields   = ('user__username', 'action')
    readonly_fields = ('timestamp',)

    def has_module_perms(self, request):
        return not is_sec(request.user)

    def has_view_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)