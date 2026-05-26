"""
restore_data.py
===============
Put this file in your project root (same folder as manage.py).
Run it with: python restore_data.py

What it does:
  1. Reads your SQL file and fixes all broken French accent characters
  2. Connects to your PostgreSQL database
  3. Runs all the INSERT statements cleanly
  4. Sets correct passwords for all users
  5. Sets admin/secretaire roles correctly

Usage:
  python restore_data.py
"""

import os
import sys
import django

# ── 1. Setup Django ────────────────────────────────────────────────────────────
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hospital.settings')
django.setup()

# ── 2. Configuration ──────────────────────────────────────────────────────────

# Put your SQL file name here (must be in the same folder as this script)
SQL_FILE = 'hospital_db_complete.sql'

# Password all users will get after restore
DEFAULT_PASSWORD = 'hospital123'

# ── 3. Fix broken French characters (Windows-1252 → UTF-8) ───────────────────

ENCODING_FIXES = {
    # Most common broken French accents from Windows-1252 misread as UTF-8
    'Ã©': 'é',  'Ã¨': 'è',  'Ãª': 'ê',  'Ã«': 'ë',
    'Ã ': 'à',  'Ã¢': 'â',  'Ã¤': 'ä',
    'Ã®': 'î',  'Ã¯': 'ï',
    'Ã´': 'ô',  'Ã¶': 'ö',
    'Ã¹': 'ù',  'Ã»': 'û',  'Ã¼': 'ü',
    'Ã§': 'ç',
    'Å"': 'œ',  'Å½': 'Ž',
    'Ã‰': 'É',  'Ã€': 'À',  'Ã‚': 'Â',
    'Ã‹': 'Ë',  'ÃŽ': 'Î',  'Ã"': 'Ô',
    'Ã™': 'Ù',  'Ã›': 'Û',  'Ã‡': 'Ç',
    # Extra common ones
    'modÃ©rÃ©':   'modéré',
    'pÃ©diatrique': 'pédiatrique',
    'gÃ©nÃ©rale':   'générale',
    'spÃ©cialitÃ©': 'spécialité',
    'mÃ©decin':     'médecin',
    'pÃ¨re':        'père',
    'mÃ¨re':        'mère',
    'Ã©cole':       'école',
}


def fix_encoding(text):
    for broken, correct in ENCODING_FIXES.items():
        text = text.replace(broken, correct)
    return text


# ── 4. Read and fix SQL file ──────────────────────────────────────────────────

script_dir = os.path.dirname(os.path.abspath(__file__))
sql_path   = os.path.join(script_dir, SQL_FILE)

if not os.path.exists(sql_path):
    print(f"❌ SQL file not found: {sql_path}")
    print(f"   Make sure '{SQL_FILE}' is in the same folder as this script.")
    sys.exit(1)

print(f"📂 Reading SQL file: {sql_path}")

# Try reading with UTF-8 first, fallback to latin-1 if needed
try:
    with open(sql_path, 'r', encoding='utf-8') as f:
        sql_content = f.read()
    print("   ✓ Read as UTF-8")
except UnicodeDecodeError:
    with open(sql_path, 'r', encoding='latin-1') as f:
        sql_content = f.read()
    print("   ⚠ File was latin-1 encoded — converting to UTF-8")

# Fix broken characters
sql_content = fix_encoding(sql_content)
print("   ✓ Encoding fixed")


# ── 5. Split into individual statements ──────────────────────────────────────

def split_sql(sql):
    """Split SQL into individual statements, skip comments and empty lines."""
    statements = []
    current    = []

    for line in sql.split('\n'):
        stripped = line.strip()

        # Skip pure comment lines and empty lines
        if stripped.startswith('--') or not stripped:
            continue

        current.append(line)

        # End of statement
        if stripped.endswith(';'):
            stmt = '\n'.join(current).strip()
            if stmt:
                statements.append(stmt)
            current = []

    return statements


statements = split_sql(sql_content)
print(f"   ✓ Found {len(statements)} SQL statements")


# ── 6. Execute statements ─────────────────────────────────────────────────────

from django.db import connection

print("\n🔄 Inserting data...")

success = 0
skipped = 0
errors  = []

for i, stmt in enumerate(statements):
    try:
        with connection.cursor() as cursor:
            cursor.execute(stmt)
        success += 1
    except Exception as e:
        err_msg = str(e).lower()
        # Duplicate key = already exists, just skip silently
        if 'duplicate' in err_msg or 'unique' in err_msg or 'already exists' in err_msg or 'dupliquée' in err_msg:
            skipped += 1
        else:
            errors.append(f"  Line ~{i+1}: {str(e)[:120]}")

print(f"   ✓ Inserted:  {success}")
print(f"   ⏭ Skipped (duplicates): {skipped}")

if errors:
    print(f"   ❌ Errors: {len(errors)}")
    for err in errors[:10]:  # show max 10 errors
        print(err)
else:
    print("   ✓ No errors")


# ── 7. Set passwords ──────────────────────────────────────────────────────────

print(f"\n🔑 Setting password '{DEFAULT_PASSWORD}' for all users...")

from django.contrib.auth.hashers import make_password
from users.models import Users

count = Users.objects.all().update(password=make_password(DEFAULT_PASSWORD))
print(f"   ✓ Updated {count} users")


# ── 8. Fix roles ──────────────────────────────────────────────────────────────

print("\n👥 Fixing user roles...")

# Make sure admin is superuser
admin_count = Users.objects.filter(role='ADMIN').update(is_superuser=True, is_staff=True)
print(f"   ✓ {admin_count} ADMIN users set as superuser")

# Make secretaires staff (not superuser) so they can access Django admin with limited permissions
sec_count = Users.objects.filter(username__in=['sec.fatima', 'sec.karima']).update(
    role='SECRETAIRE', is_superuser=False, is_staff=True
)
print(f"   ✓ {sec_count} SECRETAIRE users fixed")

# Assign Django admin permissions to secretaires
from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType
from consultations.models import Appointment
from users.models import Patients, Doctors

try:
    ct_appt    = ContentType.objects.get_for_model(Appointment)
    ct_patient = ContentType.objects.get_for_model(Patients)
    ct_doctor  = ContentType.objects.get_for_model(Doctors)

    perms = Permission.objects.filter(
        content_type__in=[ct_appt, ct_patient, ct_doctor],
        codename__in=[
            'view_appointment', 'add_appointment', 'change_appointment',
            'view_patients', 'view_doctors',
        ]
    )

    for sec in Users.objects.filter(role='SECRETAIRE'):
        sec.user_permissions.set(perms)
        print(f"   ✓ Permissions set for {sec.username}")

except Exception as e:
    print(f"   ⚠ Could not set permissions: {e}")


# ── 9. Summary ────────────────────────────────────────────────────────────────

print("\n" + "="*50)
print("✅ RESTORE COMPLETE")
print("="*50)

from consultations.models import Appointment, Consultation

print(f"  Users:         {Users.objects.count()}")
print(f"  Doctors:       {Doctors.objects.count()}")
print(f"  Patients:      {Patients.objects.count()}")
print(f"  Appointments:  {Appointment.objects.count()}")
print(f"  Consultations: {Consultation.objects.count()}")

print(f"\n  All passwords:  {DEFAULT_PASSWORD}")
print(f"  Admin login:    admin / {DEFAULT_PASSWORD}")
print(f"  Doctor login:   dr.amrani / {DEFAULT_PASSWORD}")
print(f"  Parent login:   parent.lina / {DEFAULT_PASSWORD}")
print(f"  Secretary:      sec.fatima / {DEFAULT_PASSWORD}")
print("\n  Run: python manage.py runserver")
print("="*50)
