from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Address, Users, Specialty, Doctors, Secretaire, Patients, Reste_token, TraceAction


def is_sec(user):
    return getattr(user, 'role', '') == 'SECRETAIRE'


# ── Users ─────────────────────────────────────────────────────────────────────
@admin.register(Users)
class UsersAdmin(UserAdmin):
    list_display  = ('username', 'email', 'role', 'is_active', 'is_staff', 'date_joined')
    list_filter   = ('role', 'is_active')
    search_fields = ('username', 'email', 'first_name', 'last_name')

    # Edit existing user — shows address
    fieldsets = UserAdmin.fieldsets + (
        ('Informations supplémentaires', {
            'fields': ('role', 'phone', 'address')  # ← address here
        }),
    )

    # Create new user — shows address
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Informations supplémentaires', {
            'fields': ('role', 'phone', 'email', 'address')  # ← address here
        }),
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


# ── Address ───────────────────────────────────────────────────────────────────
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


# ── Specialty ─────────────────────────────────────────────────────────────────
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


# ── Doctors ───────────────────────────────────────────────────────────────────
@admin.register(Doctors)
class DoctorsAdmin(admin.ModelAdmin):
    list_display  = ('user', 'specialty', 'ville', 'actif', 'numero_ordre_medecins')
    list_filter   = ('specialty', 'actif')
    search_fields = ('user__username', 'user__last_name', 'ville')
    fieldsets = (
        ('Médecin', {
            'fields': ('user', 'specialty', 'numero_ordre_medecins', 'actif')
        }),
        ('Informations', {
            'fields': ('bio', 'ville', 'horaire_travail', 'photo')
        }),
    )

    def has_view_permission(self, request, obj=None):
        return True  # secretaire can VIEW doctors

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


# ── Secretaire ────────────────────────────────────────────────────────────────
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


# ── Patients ──────────────────────────────────────────────────────────────────
@admin.register(Patients)
class PatientsAdmin(admin.ModelAdmin):
    list_display  = ('first_name', 'last_name', 'birth_date', 'gender', 'groupe_sanguin', 'parent')
    list_filter   = ('gender', 'groupe_sanguin')
    search_fields = ('first_name', 'last_name', 'parent__username')

    # ← fieldsets added so all fields show correctly
    fieldsets = (
        ('Informations personnelles', {
            'fields': ('parent', 'first_name', 'last_name', 'birth_date', 'gender')
        }),
        ('Médical', {
            'fields': ('groupe_sanguin',)
        }),
        ('Contact', {
            'fields': ('telephone_parent', 'email')
        }),
    )

    def has_view_permission(self, request, obj=None):
        return True  # secretaire can VIEW patients

    def has_add_permission(self, request):
        return not is_sec(request.user)

    def has_change_permission(self, request, obj=None):
        return not is_sec(request.user)

    def has_delete_permission(self, request, obj=None):
        return not is_sec(request.user)


# ── Reset Token ───────────────────────────────────────────────────────────────
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


# ── TraceAction ───────────────────────────────────────────────────────────────
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