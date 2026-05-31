import 'package:flutter/material.dart';
import 'package:medical/schedule.dart';
import 'package:medical/notification.dart';
import 'package:medical/firstpage.dart';
import 'package:medical/Languagechange.dart';
import 'package:medical/phonenum.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    const Row(
                      children: [
                        Icon(Icons.person_outline, size: 28),
                        SizedBox(width: 8),
                        Text('Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Profile card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4DB6AC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person,
                                size: 50, color: Color(0xFF4DB6AC)),
                          ),
                          const SizedBox(height: 12),
                          const Text('Sarah Johnson',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('sarah.johnson@email.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit,
                                color: Colors.white, size: 16),
                            label: const Text('Edit Profile',
                                style: TextStyle(color: Colors.white)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Info section
                    const Text('Personal Info',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoItem(Icons.phone, 'Phone', '+213 555 123 456'),
                    _buildInfoItem(Icons.location_on, 'Address', 'Oran, Algeria'),
                    _buildInfoItem(Icons.cake, 'Date of Birth', 'Jan 15, 1990'),
                    _buildInfoItem(Icons.bloodtype, 'Blood Type', 'A+'),
                    const SizedBox(height: 24),

                                              const Text('Settings',
                      style: TextStyle(
                                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSettingItem(icon :Icons.notifications_none, title:'Notifications',onTap: () {}),
                    _buildSettingItem(icon :Icons.phone, title:'Edit phone number',onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditPhoneNumberScreen()));
                    }),
                    _buildSettingItem(icon:Icons.lock_outline, title: 'Privacy & Security', onTap: () {}),
                    _buildSettingItem(icon:Icons.help_outline, title: 'Help & Support', onTap: () {}),
                    _buildSettingItem(icon:Icons.language, title: 'Language',onTap:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LanguageSettingScreen()));
                    }),
                    _buildSettingItem(icon:Icons.logout, title: 'Logout',onTap:  () {}),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4DB6AC), size: 20),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
              Text(value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF1A7369),
    Color textColor = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(icon, color: iconColor),
            title: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            trailing:const  Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      );
  }










  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4DB6AC),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'HOME', false, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MedicalAppHome()));
          }),
          _buildNavItem(Icons.calendar_month, 'SCHEDULE', false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Schedule()),
            );
          }),
          _buildNavItem(Icons.notifications_none, 'NOTIFICATION', false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          }),
          _buildNavItem(Icons.person_outline, 'PROFILE', true, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}