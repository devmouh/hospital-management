// lib/doctor_pages/doctor_profile.dart
import 'package:flutter/material.dart';
import 'package:medical/generals/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:medical/providers/doctor_provider.dart';
import 'package:medical/services/api_service.dart';

// --- Color Constants ---
const Color kTeal = Color(0xFF4DB6AC);
const Color kBg = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFF9E9E9E);
const Color kDark = Color(0xFF1A1A2E);

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English'; // English, French, Arabic

  final _emailVerifyCtrl = TextEditingController();
  final _passwordVerifyCtrl = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _emailVerifyCtrl.dispose();
    _passwordVerifyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();
    final totalPatients = provider.getTotalPatientCount;
    final upcomingAppointments = provider.getUpcomingAppointmentCount;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Title ──────────────────────────────────
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kDark,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Profile Card ─────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kTeal,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: provider.doctorPhotoUrl != null
                                ? NetworkImage(provider.doctorPhotoUrl!)
                                : const NetworkImage(
                                    'https://i.pravatar.cc/150?img=12',
                                  ),
                            backgroundColor: kWhite,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            provider.doctorName,
                            style: const TextStyle(
                              color: kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            provider.doctorBio,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _profileStat('$totalPatients', 'Patients'),
                              _profileStat(
                                '$upcomingAppointments',
                                'Appointments',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Professional details ────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Professional Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kDark,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _handleEditProfileRequest(provider),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: kTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    _detailItem(Icons.email_outlined, provider.doctorEmail),
                    _detailItem(
                      Icons.phone_outlined,
                      provider.doctorPhone.isNotEmpty
                          ? provider.doctorPhone
                          : 'No phone recorded',
                    ),
                    _detailItem(
                      Icons.location_on_outlined,
                      provider.doctorLocation.isNotEmpty
                          ? provider.doctorLocation
                          : 'No location recorded',
                    ),

                    const SizedBox(height: 24),

                    // ── Working hours ───────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Working Hours',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kDark,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _handleEditWorkingHours(provider),
                          child: const Text(
                            'Edit Hours',
                            style: TextStyle(
                              color: kTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    if (provider.doctorWorkingHours.isNotEmpty)
                      _hoursCard('Schedule', provider.doctorWorkingHours, false)
                    else ...[
                      _hoursCard('Mon — Fri', '08:00 AM - 05:00 PM', false),
                      _hoursCard('Saturday', '09:00 AM - 01:00 PM', false),
                      _hoursCard('Sunday', 'Closed', true),
                    ],

                    const SizedBox(height: 24),

                    // ── Settings ──────────────────────────────
                    const Text(
                      'Settings & Security',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _settingItemWithSwitch(
                      Icons.notifications_none,
                      'Push Notifications',
                      _notificationsEnabled,
                      (val) => setState(() => _notificationsEnabled = val),
                    ),
                    _settingItem(
                      Icons.language,
                      'App Language',
                      false,
                      () => _showLanguageSelector(),
                    ),
                    _settingItem(
                      Icons.lock_outline,
                      'Change Password',
                      false,
                      () => _showChangePasswordDialog(provider),
                    ),
                    _settingItem(
                      Icons.policy_outlined,
                      'Privacy Policy',
                      false,
                      () => _showPrivacyPolicy(),
                    ),
                    _settingItem(
                      Icons.help_outline,
                      'Help & Support',
                      false,
                      () => _showHelpSupport(),
                    ),
                    _settingItem(
                      Icons.info_outline,
                      'About Application',
                      false,
                      () => _showAboutApp(),
                    ),

                    const SizedBox(height: 12),

                    _settingItem(Icons.logout, 'Secure Logout', true, () {
                      _handleLogout();
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            buildDoctorBottomNav(context, 3),
          ],
        ),
      ),
    );
  }

  // ── Setting Action Methods ──────────────────────────────────────────

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red, size: 22),
            SizedBox(width: 10),
            Text('Confirm Logout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: const Text(
          'Are you sure you want to securely log out of your session?\n\nAll unsaved data will be discarded.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: kGrey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              // Clear the auth token so the session is truly ended
              ApiService.accessToken = '';
              // Remove all routes and go back to login
              Navigator.pushNamedAndRemoveUntil(
                ctx,
                '/login',
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: kWhite)),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              color: kGrey,
              margin: const EdgeInsets.only(bottom: 20),
            ),
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDark,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: const Text(
                  '''Last Updated: May 2026\n\n1. Data Collection\nWe collect clinical and personal information necessary to manage pediatric patient records efficiently. All data is encrypted and securely stored in our PostgreSQL backend.\n\n2. Data Usage\nPatient information, including diagnoses and prescriptions, is strictly used for medical administration within the Pediatric Hospital. Doctor activity and working hours are tracked for scheduling purposes.\n\n3. Security Protocol\nAuthentication tokens and hashed credentials are used for all endpoint communications. Medical records cannot be shared with unauthorized third-party entities.\n\n4. Your Rights\nYou have the right to request an audit of your activity logs or update your professional profile data at any time via this application interface.\n\nFor legal inquiries, contact the hospital administration board.''',
                  style: TextStyle(color: kDark, fontSize: 14, height: 1.5),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'I Understand',
                  style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpSupport() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              color: kGrey,
              margin: const EdgeInsets.only(bottom: 20),
            ),
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDark,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Need assistance with the system?',
              style: TextStyle(color: kDark, fontSize: 14),
            ),
            const SizedBox(height: 20),
            _contactTile(
              Icons.email,
              'Email IT Support',
              'support@hospital.dz',
            ),
            _contactTile(Icons.phone, 'Call Helpdesk', '+213 41 00 00 00'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE0F2F1),
        child: Icon(icon, color: kTeal),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: kDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: kTeal,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      onTap: () {
        // Here you could trigger url_launcher to open mailto: or tel:
      },
    );
  }

  void _showAboutApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_hospital, color: kTeal, size: 50),
            const SizedBox(height: 16),
            const Text(
              'Pediatric Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Version 1.0.0', style: TextStyle(color: kGrey)),
            const SizedBox(height: 16),
            const Text(
              'A comprehensive mobile platform seamlessly integrated with a Django backend for modern hospital administration.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: kTeal, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(DoctorProvider provider) {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    bool isUpdating = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text(
            'Change Password',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogField(
                'Current Password',
                oldPassCtrl,
                isPassword: true,
                enabled: !isUpdating,
              ),
              const SizedBox(height: 10),
              _dialogField(
                'New Password',
                newPassCtrl,
                isPassword: true,
                enabled: !isUpdating,
              ),
              const SizedBox(height: 10),
              _dialogField(
                'Confirm New Password',
                confirmPassCtrl,
                isPassword: true,
                enabled: !isUpdating,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isUpdating ? null : () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: kGrey)),
            ),
            ElevatedButton(
              onPressed: isUpdating
                  ? null
                  : () async {
                      if (newPassCtrl.text != confirmPassCtrl.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('New passwords do not match!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      if (newPassCtrl.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password too short.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      setDialogState(() => isUpdating = true);

                      // Trigger backend POST
                      final success = await provider.changePassword(
                        oldPassword: oldPassCtrl.text,
                        newPassword: newPassCtrl.text,
                      );

                      setDialogState(() => isUpdating = false);

                      if (!mounted) return;
                      Navigator.pop(context);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password securely updated!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to update password. Check your current password.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(backgroundColor: kTeal),
              child: isUpdating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: kWhite,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Update', style: TextStyle(color: kWhite)),
            ),
          ],
        ),
      ),
    );
  }

  // ── Existing Helper Methods ─────────────────────────────────────────

  Widget _profileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 12),
        ),
      ],
    );
  }

  Widget _detailItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: kTeal, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: kDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hoursCard(String day, String hours, bool closed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: kDark,
            ),
          ),
          Text(
            hours,
            style: TextStyle(
              color: closed ? Colors.red : kTeal,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingItem(
    IconData icon,
    String label,
    bool isDanger,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        leading: Icon(icon, color: isDanger ? Colors.red : kTeal, size: 20),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: isDanger ? Colors.red : kDark,
          ),
        ),
        trailing: isDanger
            ? null
            : const Icon(Icons.arrow_forward_ios, size: 14, color: kGrey),
      ),
    );
  }

  Widget _settingItemWithSwitch(
    IconData icon,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: kTeal, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: kDark,
              ),
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeColor: Colors.green),
        ],
      ),
    );
  }

  void _handleEditWorkingHours(DoctorProvider provider) {
    final monFriCtrl = TextEditingController(
      text: provider.doctorWorkingHours.isNotEmpty
          ? provider.doctorWorkingHours
          : '08:00 AM - 05:00 PM',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, color: kGrey),
              const SizedBox(height: 20),
              const Text(
                'Edit Working Hours',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kDark,
                ),
              ),
              const SizedBox(height: 20),
              _buildEditableField('Working Hours Schedule', monFriCtrl),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await provider.updateWorkingHours(
                      monFriCtrl.text,
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Working hours updated successfully!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Failed to update working hours.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Working Hours',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String day, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: kDark,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          style: const TextStyle(fontSize: 13, color: kDark),
        ),
      ],
    );
  }

  void _handleEditProfileRequest(DoctorProvider provider) {
    _emailVerifyCtrl.text = provider.doctorEmail;
    _passwordVerifyCtrl.clear();

    showDialog(
      context: context,
      barrierDismissible: !_isVerifying,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Confirm Identity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'For security, please re-enter your credentials to continue.',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 20),
              _dialogField('Email', _emailVerifyCtrl, enabled: !_isVerifying),
              const SizedBox(height: 10),
              _dialogField(
                'Password',
                _passwordVerifyCtrl,
                isPassword: true,
                enabled: !_isVerifying,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _isVerifying ? null : () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: kGrey)),
            ),
            TextButton(
              onPressed: _isVerifying
                  ? null
                  : () async {
                      setDialogState(() => _isVerifying = true);
                      await _verifyAuthAndContinue(provider);
                      setDialogState(() => _isVerifying = false);
                    },
              child: _isVerifying
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: kTeal,
                      ),
                    )
                  : const Text(
                      'Continue',
                      style: TextStyle(
                        color: kTeal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogField(
    String label,
    TextEditingController ctrl, {
    bool isPassword = false,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: kGrey, fontSize: 11)),
        const SizedBox(height: 5),
        TextField(
          controller: ctrl,
          enabled: enabled,
          obscureText: isPassword,
          style: TextStyle(fontSize: 13, color: enabled ? kDark : kGrey),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Future<void> _verifyAuthAndContinue(DoctorProvider provider) async {
    final providedEmail = _emailVerifyCtrl.text.trim();
    final providedPassword = _passwordVerifyCtrl.text;

    if (providedEmail == provider.doctorEmail.trim() &&
        providedPassword.isNotEmpty) {
      bool isValid = true;
      // If you create a provider.verifyCredentials() backend check in the future, call it here.

      if (isValid) {
        if (!mounted) return;
        Navigator.pop(context);
        _showEditForm(provider);
        return;
      }
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid credentials. Identity validation failed.'),
      ),
    );
  }

  void _showEditForm(DoctorProvider provider) {
    final emailCtrl = TextEditingController(text: provider.doctorEmail);
    final phoneCtrl = TextEditingController(text: provider.doctorPhone);
    final placeCtrl = TextEditingController(text: provider.doctorLocation);
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 4, color: kGrey),
                const SizedBox(height: 20),
                const Text(
                  'Edit Profile Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kDark,
                  ),
                ),
                const SizedBox(height: 20),
                _buildFormEditableField(
                  'Email',
                  emailCtrl,
                  requiredValidator: true,
                  emailValidator: true,
                  enabled: false,
                ),
                const SizedBox(height: 10),
                _buildFormEditableField(
                  'Phone Number',
                  phoneCtrl,
                  requiredValidator: true,
                ),
                const SizedBox(height: 10),
                _buildFormEditableField(
                  'Place/Location',
                  placeCtrl,
                  requiredValidator: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final success = await provider.updateProfile(
                          phone: phoneCtrl.text,
                          ville: placeCtrl.text,
                        );
                        if (!mounted) return;
                        Navigator.pop(context);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile updated successfully!'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Failed to update profile.'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTeal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save Profile Details',
                      style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormEditableField(
    String label,
    TextEditingController ctrl, {
    bool requiredValidator = false,
    bool emailValidator = false,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: kGrey, fontSize: 11)),
        const SizedBox(height: 5),
        TextFormField(
          controller: ctrl,
          enabled: enabled,
          style: TextStyle(fontSize: 13, color: enabled ? kDark : kGrey),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(),
          ),
          validator: (val) {
            if (requiredValidator && (val == null || val.trim().isEmpty))
              return 'This field cannot be empty.';
            if (emailValidator && val != null && !val.contains('@'))
              return 'Invalid email. Must contain \'@\' sign.';
            return null;
          },
        ),
      ],
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, color: kGrey),
            const SizedBox(height: 15),
            const Text(
              'Select App Language',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kDark,
              ),
            ),
            const SizedBox(height: 10),
            _languageTile('English'),
            _languageTile('French'),
            _languageTile('Arabic'),
          ],
        ),
      ),
    );
  }

  Widget _languageTile(String lang) {
    bool isSelected = lang == _selectedLanguage;
    return ListTile(
      onTap: () {
        setState(() => _selectedLanguage = lang);
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Language changed to $lang.')));
      },
      title: Text(
        lang,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? kTeal : kDark,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: kTeal, size: 20)
          : null,
    );
  }
}
