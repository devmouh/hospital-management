import 'package:flutter/material.dart';
import 'package:medical/schedule.dart';
import 'package:medical/profile.dart';
import 'package:medical/firstpage.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    const Row(
                      children: [
                        Icon(Icons.notifications_none, size: 28),
                        SizedBox(width: 8),
                        Text('Notifications',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Notification cards
                    Expanded(
                      child: ListView(
                        children: [
                          _buildNotificationCard(
                            icon: Icons.calendar_month,
                            color: const Color(0xFF4DB6AC),
                            title: 'Appointment Reminder',
                            subtitle: 'Dr. Sarah Jenkins tomorrow at 10:30 AM',
                            time: '2h ago',
                          ),
                          _buildNotificationCard(
                            icon: Icons.check_circle,
                            color: Colors.green,
                            title: 'Appointment Confirmed',
                            subtitle: 'Dr. James Robinson on Sept 17 at 10:30 AM',
                            time: '5h ago',
                          ),
                          _buildNotificationCard(
                            icon: Icons.cancel,
                            color: Colors.red,
                            title: 'Appointment Cancelled',
                            subtitle: 'Your appointment with Dr. Lee was cancelled',
                            time: '1d ago',
                          ),
                          _buildNotificationCard(
                            icon: Icons.medical_services,
                            color: Colors.orange,
                            title: 'New Test Results',
                            subtitle: 'Liam\'s blood test results are now available',
                            time: '2d ago',
                          ),
                          _buildNotificationCard(
                            icon: Icons.vaccines,
                            color: Colors.purple,
                            title: 'Vaccination Due',
                            subtitle: 'Liam\'s vaccination is due next week',
                            time: '3d ago',
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildNotificationCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Icon circle
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Time
          Text(time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
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
          _buildNavItem(Icons.notifications_none, 'NOTIFICATION', true, () {}),
          _buildNavItem(Icons.person_outline, 'PROFILE', false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }),
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