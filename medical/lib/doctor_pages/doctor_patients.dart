// lib/doctor_pages/doctor_patients.dart
import 'package:flutter/material.dart';
import 'package:medical/generals/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:medical/providers/doctor_provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/doctor_pages/child_profile_page.dart';
import 'package:medical/doctor_pages/doctor_schedule.dart';

// --- Local Color Constants ---
const Color kTeal  = Color(0xFF4DB6AC);
const Color kBg    = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey  = Color(0xFF9E9E9E);
const Color kDark  = Color(0xFF1A1A2E);

class DoctorPatients extends StatefulWidget {
  final bool showUrgentOnly;
  const DoctorPatients({super.key, this.showUrgentOnly = false});

  @override
  State<DoctorPatients> createState() => _DoctorPatientsState();
}

class _DoctorPatientsState extends State<DoctorPatients> {
  int _selectedFilter = 0; // 0=All Patients, 1=Active, 2=New
  String _search = '';

  @override
  Widget build(BuildContext context) {
    // List of filter choices
    final filters = widget.showUrgentOnly ? ['Urgent Cases'] : ['All Patients', 'Active', 'New'];

    final provider = context.watch<DoctorProvider>();
    final allPatients = provider.patients;
    // ── Genuinely filter the patient list based on search and status ──
    List<PatientModel> filtered = allPatients.where((p) {
      // 1. Check if name matches search
      final matchSearch =
          p.name.toLowerCase().contains(_search.toLowerCase());

      // 2. Check if status matches selected chip
      bool matchFilter = true;
      if (!widget.showUrgentOnly) {
        if (_selectedFilter == 1) {
          matchFilter = (p.status == 'ACTIVE');
        } else if (_selectedFilter == 2) {
          matchFilter = (p.status == 'NEW');
        }
      } else {
        // If showUrgentOnly, check if condition is not stable
        matchFilter = (p.condition.toLowerCase() != 'stable');
      }

      return matchSearch && matchFilter;
    }).toList();

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Title ──────────────────────────────────
                    Row(
                      children: [
                        if (Navigator.canPop(context)) ...[
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: kDark),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          widget.showUrgentOnly ? 'Urgent Cases' : 'Patient Records',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Genuine Search Field ──────────────────────
                    TextField(
                      onChanged: (v) =>
                          setState(() => _search = v),
                      decoration: InputDecoration(
                        hintText: 'Search by patient name',
                        hintStyle: const TextStyle(
                            color: kGrey, fontSize: 13),
                        prefixIcon: const Icon(Icons.search,
                            color: kGrey),
                        filled: true,
                        fillColor: kWhite,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Filter Chips ──────────────────────────
                    Row(
                      children: filters
                          .asMap()
                          .entries
                          .map((e) {
                        final sel = e.key == _selectedFilter;
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(
                                () => _selectedFilter = e.key),
                            child: AnimatedContainer(
                              duration: const Duration(
                                  milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: sel ? kTeal : kWhite,
                                borderRadius:
                                    BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x1F000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 1))
                                ],
                              ),
                              child: Text(e.value,
                                  style: TextStyle(
                                      color: sel
                                          ? kWhite
                                          : kDark,
                                      fontWeight: sel
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 12)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 14),

                    // ── Dynamic Patient List ───────────────────
                    Expanded(
                      child: filtered.isEmpty
                          ? _buildNoPatientsFound()
                          : ListView.separated(
                              itemCount: filtered.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, i) =>
                                  _patientCard(context,
                                      filtered[i], provider.appointments),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Nav, highlight Patients (index 2)
            buildDoctorBottomNav(context, 2),
          ],
        ),
      ),
    );
  }

  // Helper widget when no patients are found
  Widget _buildNoPatientsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined,
              color: kGrey.withOpacity(0.4), size: 48),
          const SizedBox(height: 10),
          const Text('No patients found',
              style: TextStyle(color: kGrey, fontSize: 14)),
        ],
      ),
    );
  }

  // ── Genuine Patient Card Widget ─────────────────────
  Widget _patientCard(BuildContext context, PatientModel patient, List<AppointmentModel> allAppointments) {
    final isNew = patient.status == 'NEW';

    // 1. Genuinely find the *very next* upcoming appt for this specific patient
    // We filter appts by patient ID and 'waiting' status
    final nextApptsForThisPatient = allAppointments.where(
        (a) => a.patientId == patient.id && a.status == 'waiting'
    ).toList();

    // Default: if no appt, go to today's schedule
    String highlightDate = '2026-04-26'; 
    String highlightApptId = '';

    if (nextApptsForThisPatient.isNotEmpty) {
      // The appointments are already sorted by time in app_data,
      // so the first one is the next one.
      final nextAppt = nextApptsForThisPatient.first;
      highlightDate = nextAppt.dateKey;
      highlightApptId = nextAppt.id;
    }

    return GestureDetector(
      // --- TAP CARD -> NAVIGATE TO PATIENT'S GENUINE PROFILE ---
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChildProfilePage(patient: patient),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 5,
                offset: Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            // --- Genuine Profile Pic ---
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(patient.photoUrl),
              backgroundColor: kBg,
            ),
            const SizedBox(width: 12),

            // --- Genuine Patient Info ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patient.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: kDark)),
                  Row(
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isNew
                              ? const Color(0xFFE3F2FD) // Blueish bg for New
                              : const Color(0xFFE8F5E9), // Greenish bg for Active
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(patient.status,
                            style: TextStyle(
                                color: isNew
                                    ? Colors.blue
                                    : Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 6),
                      // Genuine Age
                      Text(patient.age,
                          style: const TextStyle(
                              color: kGrey, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text('LAST VISIT  ',
                          style: TextStyle(
                              color: kGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5)),
                      const Text('STATUS  ',
                          style: TextStyle(
                              color: kGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5)),
                    ],
                  ),
                  Row(
                    children: [
                      // Genuine Last Visit
                      Text(patient.lastVisit,
                          style: const TextStyle(
                              fontSize: 11, color: kDark)),
                      const SizedBox(width: 16),
                      // Genuine Condition
                      Text(patient.condition,
                          style: const TextStyle(
                              fontSize: 11, color: kDark)),
                    ],
                  ),
                ],
              ),
            ),

            // --- Calendar Icon for Next Appointment ---
            if (highlightApptId.isNotEmpty)
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DoctorSchedule(
                      highlightDateKey: highlightDate,
                      highlightAppointmentId: highlightApptId,
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1), // Very pale teal
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.calendar_month,
                      color: kTeal, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}