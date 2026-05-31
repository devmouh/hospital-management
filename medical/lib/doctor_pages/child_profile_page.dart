// lib/doctor_pages/child_profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/providers/doctor_provider.dart';
import 'package:medical/doctor_pages/vitals_notes_page.dart';
import 'package:medical/doctor_pages/file_browser_page.dart';

const Color kTeal = Color(0xFF4DB6AC);
const Color kBg = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFF9E9E9E);
const Color kDark = Color(0xFF1A1A2E);

class ChildProfilePage extends StatelessWidget {
  final PatientModel patient;
  const ChildProfilePage({super.key, required this.patient});

  void _showHealthJournal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9), // Clean Light Green Background
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Bar Indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.menu_book, color: Colors.green, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Health Journal History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF1B5E20)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: Colors.green, thickness: 1),
              const SizedBox(height: 12),
              Expanded(
                child: FutureBuilder<List<ConsultationModel>>(
                  future: context
                      .read<DoctorProvider>()
                      .fetchPatientConsultations(patient.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error fetching history: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final list = snapshot.data ?? [];
                    if (list.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history_toggle_off,
                                size: 50, color: Colors.green),
                            SizedBox(height: 12),
                            Text(
                              'No health history logs recorded.',
                              style: TextStyle(
                                color: Color(0xFF2E7D32),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final consult = list[index];
                        final diag = consult.diagnostics.isNotEmpty
                            ? consult.diagnostics.first
                            : null;
                        final trait = consult.traitements.isNotEmpty
                            ? consult.traitements.first
                            : null;

                        Color severityColor = Colors.green;
                        if (diag?.gravite == 'MODEREE') {
                          severityColor = Colors.orange;
                        } else if (diag?.gravite == 'SEVERE') {
                          severityColor = Colors.red;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8F5E9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.assignment_turned_in,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                diag?.nomMaladie ?? 'Routine Checkup',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDark,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                formatDateString(consult.dateConsultation),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 11,
                                ),
                              ),
                              childrenPadding: const EdgeInsets.all(16),
                              children: [
                                const Divider(height: 1),
                                const SizedBox(height: 10),
                                // Vitals pills
                                Row(
                                  children: [
                                    _vitalTag(
                                      Icons.monitor_weight_outlined,
                                      '${formatNum(consult.poids)} kg',
                                    ),
                                    const SizedBox(width: 8),
                                    _vitalTag(
                                      Icons.height,
                                      '${formatNum(consult.taille)} cm',
                                    ),
                                    const SizedBox(width: 8),
                                    _vitalTag(
                                      Icons.thermostat,
                                      '${formatNum(consult.temperature)} °C',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Diagnostics info
                                if (diag != null) ...[
                                  _infoRow(
                                    'Classification',
                                    diag.typeLabel,
                                    textColor: Colors.blue[800],
                                  ),
                                  _infoRow(
                                    'Severity',
                                    diag.graviteLabel,
                                    textColor: severityColor,
                                    bold: true,
                                  ),
                                  if (diag.commentaireMedical.isNotEmpty)
                                    _infoRow(
                                      'Doctor Note',
                                      diag.commentaireMedical,
                                    ),
                                ],
                                if (consult.observation.isNotEmpty &&
                                    consult.observation !=
                                        'Patient parameters checked.')
                                  _infoRow(
                                    'Observation',
                                    consult.observation,
                                  ),
                                // Treatment info
                                if (trait != null) ...[
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F8E9),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xFFDCEDC8),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Prescribed Treatment:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF33691E),
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${trait.medicament} (${trait.dose})',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: kDark,
                                          ),
                                        ),
                                        Text(
                                          'Duration: ${trait.duree}',
                                          style: const TextStyle(
                                            color: kGrey,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _vitalTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.green),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: kDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value,
      {Color? textColor, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: kGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: textColor ?? kDark,
                fontSize: 12,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.person_outline, color: kTeal, size: 22),
            SizedBox(width: 8),
            Text(
              'Child Profile',
              style: TextStyle(
                color: kDark,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile Card ──────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kTeal, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(patient.photoUrl),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    patient.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  Text(
                    patient.gender,
                    style: const TextStyle(color: kGrey, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statPill(Icons.cake_outlined, 'AGE', patient.age),
                      _statPill(
                        Icons.monitor_weight_outlined,
                        'WEIGHT',
                        patient.weight.contains('kg') ? patient.weight : '${patient.weight} kg',
                      ),
                      _statPill(Icons.height, 'HEIGHT', patient.height.contains('cm') ? patient.height : '${patient.height} cm'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VitalsNotesPage(patient: patient),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kTeal),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monitor_heart_outlined,
                            color: kTeal,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'View Vitals & History',
                            style: TextStyle(
                              color: kTeal,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoPill(
                  Icons.bloodtype_outlined,
                  'Blood Type',
                  patient.bloodType,
                  const Color(0xFFFFEBEE),
                  Colors.red,
                ),
                const SizedBox(width: 12),
                _infoPill(
                  Icons.circle,
                  'Status',
                  patient.status,
                  patient.status == 'ACTIVE'
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFE3F2FD),
                  patient.status == 'ACTIVE' ? Colors.green : Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Grid Actions ──────────────────────────────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                GestureDetector(
                  onTap: () => _showHealthJournal(context),
                  child: _infoCard(
                    Icons.menu_book,
                    'Health Journal',
                    'VIEW TIMELINE',
                    const Color(0xFFE8F5E9),
                    Colors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FileBrowserPage(patient: patient),
                    ),
                  ),
                  child: _infoCard(
                    Icons.folder_open,
                    'Medical Files',
                    'DOWNLOAD PDFS',
                    const Color(0xFFE3F2FD),
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statPill(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: kTeal, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: kGrey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: kDark,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _infoPill(
    IconData icon,
    String label,
    String value,
    Color bg,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: kGrey, fontSize: 10)),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String title,
    String subtitle,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kDark,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: iconColor,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
