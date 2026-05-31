import 'package:flutter/material.dart';
import 'package:medical/Search.dart';
import 'package:medical/login.dart';
import 'package:medical/notification.dart';
import 'package:medical/schedule.dart';
import 'package:medical/doctor_pages/doctor_home.dart';
import 'package:medical/doctor_pages/doctor_patients.dart';
import 'package:medical/doctor_pages/doctor_schedule.dart';
import 'package:medical/doctor_pages/doctor_profile.dart';

const Color kTeal    = Color(0xFF4DB6AC);
const Color kBg      = Color(0xFFF5F5F5);
const Color kWhite   = Colors.white;
const Color kGrey    = Colors.grey;

// ============================================================
// SHARED BOTTOM NAV
// ============================================================
Widget buildDoctorBottomNav(BuildContext context, int selected) {
  final items = [
    {'icon': Icons.home_outlined,       'label': 'HOME'},
    {'icon': Icons.calendar_month,      'label': 'SCHEDULE'},
    {'icon': Icons.people_outline,      'label': 'PATIENTS'},
    {'icon': Icons.person_outline,      'label': 'PROFILE'},
  ];

  return Container(
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: kTeal,
      borderRadius: BorderRadius.circular(32),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(items.length, (i) {
        final isSelected = i == selected;
        return GestureDetector(
          onTap: () {
            if (i == selected) return;
            final pages = [
              const DoctorHome(),
              const DoctorSchedule(),
              const DoctorPatients(),
              const DoctorProfile(),
            ];
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => pages[i]),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.25)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Icon(items[i]['icon'] as IconData,
                    color: kWhite, size: 20),
                if (isSelected) ...[
                  const SizedBox(width: 6),
                  Text(items[i]['label'] as String,
                      style: const TextStyle(
                          color: kWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          ),
        );
      }),
    ),
  );
}
