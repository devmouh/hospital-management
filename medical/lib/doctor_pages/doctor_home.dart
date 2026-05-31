// lib/doctor_pages/doctor_home.dart
import 'package:flutter/material.dart';
import 'package:medical/generals/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:medical/providers/doctor_provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/doctor_pages/doctor_schedule.dart';
import 'package:medical/doctor_pages/doctor_profile.dart';
import 'package:medical/doctor_pages/doctor_patients.dart';

const Color kTeal = Color(0xFF4DB6AC);
const Color kBg = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFF9E9E9E);
const Color kDark = Color(0xFF1A1A2E);

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchAllData fetches dashboard + appointments + profile in parallel
      context.read<DoctorProvider>().fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();
    final todayAppts = provider.getTodayAppointments();
    final totalPatients = provider.patients.length;
    final upcomingAppts = provider.getUpcomingAppointments();

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
                    // ── Header — tap bar → profile ──────────
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DoctorProfile(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(color: Color(0x0F000000), blurRadius: 6),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: provider.doctorPhotoUrl != null
                                  ? NetworkImage(provider.doctorPhotoUrl!)
                                  : const NetworkImage(
                                          'https://i.pravatar.cc/150?img=12',
                                        )
                                        as ImageProvider,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.doctorName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: kDark,
                                    ),
                                  ),
                                  Text(
                                    provider.doctorBio,
                                    style: const TextStyle(
                                      color: kGrey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: kGrey,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Stats row ────────────────────────────
                    Row(
                      children: [
                        // TODAY'S APPOINTMENTS — tap → Schedule
                        _statCard(
                          context,
                          '${todayAppts.length}',
                          "Today's\nAppointments",
                          Icons.calendar_today,
                          kTeal,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorSchedule(
                                highlightDateKey: provider.todayDateKey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // TOTAL PATIENTS — tap → Patients page
                        _statCard(
                          context,
                          '$totalPatients',
                          'Total\nPatients',
                          Icons.people_outline,
                          const Color(0xFF448AFF),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DoctorPatients(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── Urgent cases ─────────────────────────
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DoctorPatients(showUrgentOnly: true),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEF9A9A)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.priority_high,
                                color: kWhite,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Urgent Cases',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  '${provider.urgentCasesCount} patients need immediate attention',
                                  style: const TextStyle(
                                    color: kGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '${provider.urgentCasesCount}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Upcoming appointments ────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Upcoming Appointments',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        // VIEW ALL → Schedule
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoctorSchedule(
                                highlightDateKey: provider.todayDateKey,
                              ),
                            ),
                          ),
                          child: const Text(
                            'View All',
                            style: TextStyle(color: kTeal),
                          ),
                        ),
                      ],
                    ),

                    // Show first 6 of the nearest upcoming/future appointments
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: upcomingAppts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final appt = upcomingAppts[i];
                        final patient = provider.getPatientById(appt.patientId);
                        return _appointmentTile(context, appt, patient);
                      },
                    ),
                  ],
                ),
              ),
            ),
            buildDoctorBottomNav(context, 0),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color, {
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x1F000000), blurRadius: 6),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      label,
                      style: const TextStyle(color: kGrey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 12, color: kGrey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appointmentTile(
    BuildContext context,
    AppointmentModel appt,
    PatientModel patient,
  ) {
    return GestureDetector(
      // Tap → go to Schedule highlighting this exact appointment
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DoctorSchedule(
            highlightDateKey: appt.dateKey,
            highlightAppointmentId: appt.id,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x1F000000), blurRadius: 4)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(patient.photoUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${patient.age} • ${appt.type}',
                    style: const TextStyle(color: kGrey, fontSize: 11),
                  ),
                  Text(
                    formatDateString(appt.dateRdv),
                    style: const TextStyle(color: kGrey, fontSize: 10),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  appt.time,
                  style: const TextStyle(
                    color: kTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(Icons.arrow_forward_ios, size: 12, color: kGrey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
