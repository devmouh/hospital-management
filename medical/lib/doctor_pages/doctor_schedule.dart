// lib/doctor_pages/doctor_schedule.dart
import 'package:flutter/material.dart';
import 'package:medical/generals/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:medical/providers/doctor_provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/doctor_pages/child_profile_page.dart';
import 'package:medical/doctor_pages/consultation_page.dart';

const Color kTeal  = Color(0xFF4DB6AC);
const Color kBg    = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey  = Color(0xFF9E9E9E);
const Color kDark  = Color(0xFF1A1A2E);

class DoctorSchedule extends StatefulWidget {
  final String? highlightDateKey;
  final String? highlightAppointmentId;

  const DoctorSchedule({
    super.key,
    this.highlightDateKey,
    this.highlightAppointmentId,
  });

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  int _selectedDayIndex = -1;
  int _selectedTab = 0; // 0=All 1=Waiting 2=Completed

  List<Map<String, String>> _generateWeekDays(List<AppointmentModel> appointments) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekdayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    final now = DateTime.now();
    final List<DateTime> dates = List.generate(14, (i) => now.add(Duration(days: i)));

    for (final appt in appointments) {
      if (appt.dateKey.isNotEmpty) {
        try {
          final date = DateTime.parse(appt.dateKey);
          final isDuplicate = dates.any((d) =>
              d.year == date.year && d.month == date.month && d.day == date.day);
          if (!isDuplicate) dates.add(date);
        } catch (_) {}
      }
    }

    dates.sort((a, b) => a.compareTo(b));

    return dates.map((day) {
      final dateKey = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      return {
        'label': weekdayLabels[day.weekday - 1],
        'num': day.day.toString().padLeft(2, '0'),
        'dateKey': dateKey,
        'display': '${months[day.month - 1]} ${day.day}, ${day.year}',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();
    final weekDays = _generateWeekDays(provider.appointments);

    if (weekDays.isNotEmpty && (_selectedDayIndex == -1 || _selectedDayIndex >= weekDays.length)) {
      if (widget.highlightDateKey != null) {
        final idx = weekDays.indexWhere((d) => d['dateKey'] == widget.highlightDateKey);
        _selectedDayIndex = idx >= 0 ? idx : 0;
      } else {
        final todayStr = DateTime.now().toIso8601String().split('T')[0];
        final todayIdx = weekDays.indexWhere((d) => d['dateKey'] == todayStr);
        _selectedDayIndex = todayIdx >= 0 ? todayIdx : 0;
      }
    }

    final currentDateKey = weekDays.isNotEmpty ? weekDays[_selectedDayIndex]['dateKey']! : '';
    final dayAppts = provider.getAppointmentsByDate(currentDateKey);

    List<AppointmentModel> filteredAppts;
    if (_selectedTab == 0) {
      filteredAppts = dayAppts;
    } else if (_selectedTab == 1) {
      filteredAppts = dayAppts.where((a) =>
          a.status == 'waiting' || a.status == 'PENDING' || a.status == 'CONFIRMED').toList();
    } else {
      filteredAppts = dayAppts.where((a) =>
          a.status == 'completed' || a.status == 'COMPLETED').toList();
    }

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
                    // Title
                    const Row(children: [
                      Icon(Icons.calendar_month, size: 26, color: kTeal),
                      SizedBox(width: 8),
                      Text('Schedule',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kDark)),
                    ]),

                    const SizedBox(height: 4),
                    if (weekDays.isNotEmpty)
                      Text(weekDays[_selectedDayIndex]['display']!,
                          style: const TextStyle(color: kGrey, fontSize: 13)),

                    const SizedBox(height: 14),

                    // ── Week strip ──────────────────────────
                    if (weekDays.isNotEmpty)
                      SizedBox(
                        height: 72,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weekDays.length,
                          itemBuilder: (_, i) {
                            final sel = i == _selectedDayIndex;
                            final dayApptCount =
                                provider.getAppointmentsByDate(weekDays[i]['dateKey']!).length;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedDayIndex = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 54,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: sel ? kTeal : kWhite,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x1F000000),
                                        blurRadius: 4)
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(weekDays[i]['label']!,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: sel ? kWhite : kGrey)),
                                    const SizedBox(height: 2),
                                    Text(weekDays[i]['num']!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: sel ? kWhite : kDark)),
                                    if (dayApptCount > 0)
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: sel ? kWhite : kTeal,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 14),

                    // ── Tabs ────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: ['All', 'Waiting', 'Completed']
                            .asMap()
                            .entries
                            .map((e) {
                          final sel = e.key == _selectedTab;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTab = e.key),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: sel ? kTeal : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(e.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: sel ? kWhite : kGrey,
                                        fontWeight: sel
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: 13)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Appointment list ─────────────────────
                    Expanded(
                      child: filteredAppts.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.event_busy,
                                      color: kGrey.withOpacity(0.4),
                                      size: 48),
                                  const SizedBox(height: 10),
                                  const Text('No appointments',
                                      style: TextStyle(
                                          color: kGrey, fontSize: 14)),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemCount: filteredAppts.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (_, i) {
                                final appt = filteredAppts[i];
                                final patient =
                                    provider.getPatientById(appt.patientId);
                                final isHighlighted =
                                    appt.id == widget.highlightAppointmentId;
                                return _scheduleCard(
                                    context, appt, patient,
                                    isHighlighted: isHighlighted);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            buildDoctorBottomNav(context, 1),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────

  Widget _scheduleCard(
    BuildContext context,
    AppointmentModel appt,
    PatientModel patient, {
    bool isHighlighted = false,
  }) {
    final done      = appt.status == 'completed' || appt.status == 'COMPLETED';
    final confirmed = appt.status == 'CONFIRMED';
    final cancelled = appt.status == 'CANCELLED';
    final pending   = appt.status == 'PENDING'   || appt.status == 'waiting';

    String statusText = 'Pending';
    Color  statusColor = Colors.orange;
    Color  statusBg    = const Color(0xFFFFF3E0);

    if (done) {
      statusText  = 'Completed';
      statusColor = Colors.green;
      statusBg    = const Color(0xFFE8F5E9);
    } else if (confirmed) {
      statusText  = 'Confirmed';
      statusColor = kTeal;
      statusBg    = const Color(0xFFE0F2F1);
    } else if (cancelled) {
      statusText  = 'Cancelled';
      statusColor = Colors.red;
      statusBg    = const Color(0xFFFFEBEE);
    }

    // Badge is interactive for PENDING / CONFIRMED only
    final canToggle = (pending || confirmed) && !done && !cancelled;

    Widget statusBadge = GestureDetector(
      onTap: canToggle
          ? () => _showStatusToggleDialog(context, appt, pending)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: statusBg,
          borderRadius: BorderRadius.circular(20),
          border: canToggle
              ? Border.all(
                  color: pending ? Colors.orange : kTeal,
                  width: 1.2,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              statusText,
              style: TextStyle(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
            if (canToggle) ...[
              const SizedBox(width: 4),
              Icon(Icons.swap_horiz, color: statusColor, size: 13),
            ],
          ],
        ),
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: isHighlighted
            ? Border.all(color: kTeal, width: 2)
            : Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
              color: isHighlighted
                  ? kTeal.withOpacity(0.2)
                  : const Color(0x0F000000),
              blurRadius: isHighlighted ? 12 : 5,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highlighted badge
          if (isHighlighted)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: kTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: kTeal, size: 12),
                  SizedBox(width: 4),
                  Text('Selected appointment',
                      style: TextStyle(
                          color: kTeal,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(patient.photoUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('${patient.age} • ${appt.type}',
                        style: const TextStyle(color: kGrey, fontSize: 12)),
                    Text('${appt.time}  •  ${formatDateString(appt.dateRdv)}',
                        style: const TextStyle(color: kGrey, fontSize: 11)),
                  ],
                ),
              ),
              statusBadge,
            ],
          ),

          // Hint text for toggleable status
          if (canToggle)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Tap badge to ${pending ? "confirm" : "set pending"}',
                style: TextStyle(
                  color: (pending ? Colors.orange : kTeal).withOpacity(0.65),
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChildProfilePage(patient: patient),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kTeal),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('View Profile',
                      style: TextStyle(color: kTeal, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConsultationPage(
                          patient: patient, appointment: appt),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTeal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                      done ? 'View Summary' : 'Start Consultation',
                      style: const TextStyle(color: kWhite, fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Confirmation dialog for status toggle ────────────────────────────────

  void _showStatusToggleDialog(
      BuildContext context, AppointmentModel appt, bool isPending) {
    final newStatus   = isPending ? 'CONFIRMED' : 'PENDING';
    final actionLabel = isPending ? 'Confirm Appointment' : 'Set Back to Pending';
    final actionColor = isPending ? kTeal : Colors.orange;
    final actionIcon  = isPending ? Icons.check_circle : Icons.hourglass_empty;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(actionIcon, color: actionColor, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(actionLabel,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPending
                  ? 'Are you sure you want to confirm this appointment?'
                  : 'Move this appointment back to Pending?',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: actionColor.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        context
                            .read<DoctorProvider>()
                            .getPatientById(appt.patientId)
                            .photoUrl),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appt.patientName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(
                          '${appt.time} • ${formatDateString(appt.dateRdv)}',
                          style: const TextStyle(color: kGrey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: kGrey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: actionColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = context.read<DoctorProvider>();
              final success =
                  await provider.updateAppointmentStatus(appt.id, newStatus);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success
                      ? 'Appointment ${isPending ? "confirmed" : "set to pending"} successfully!'
                      : 'Failed to update status. Please try again.'),
                  backgroundColor: success ? Colors.green : Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              isPending ? 'Confirm' : 'Set Pending',
              style: const TextStyle(color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
