import 'package:flutter/material.dart';
import 'package:medical/notification.dart';
import 'package:medical/profile.dart';
import 'package:medical/firstpage.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  int _selectedTab = 0;

  final List<Map<String, String>> appointments = [
    {
      'name': 'Dr. deriet mohamed',
      'specialty': 'Allergist',
      'time': '10:30 AM, Sept 17',
      'image': 'assets/doctor1.jpg',
    },
    {
      'name': 'Dr. adda youssef',
      'specialty': 'General Pediatrician',
      'time': '10:30 AM, Sept 17',
      'image': 'assets/doctor2.jpg',
    },
  ];

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

                    const Row(
                      children: [
                        Icon(Icons.calendar_month, size: 28),
                        SizedBox(width: 8),
                        Text('schedule',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          _buildTab('Upcoming', 0),
                          _buildTab('Completed', 1),
                          _buildTab('Canceled', 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView.separated(
                        itemCount: appointments.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return _buildAppointmentCard(appointments[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4DB6AC) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, String> doctor) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(doctor['specialty']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('TIME',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(doctor['time']!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(doctor['image']!),
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DB6AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Reschedule',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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
          _buildNavItem(Icons.calendar_month, 'SCHEDULE', true, () {}),
          // ✅ Fixed: added navigation
          _buildNavItem(Icons.notifications_none, 'NOTIFICATION', false, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          }),
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