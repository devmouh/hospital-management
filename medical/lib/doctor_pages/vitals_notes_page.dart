import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/providers/doctor_provider.dart';

const Color kTeal      = Color(0xFF4DB6AC);
const Color kBg        = Color(0xFFF5F5F5);
const Color kWhite     = Color(0xFFFFFFFF);
const Color kGrey      = Color(0xFF9E9E9E);
const Color kDark      = Color(0xFF1A1A2E);
const Color kRedLight  = Color(0xFFFFEBEE);
const Color kRed       = Color(0xFFEF5350);

class VitalsNotesPage extends StatefulWidget {
  final PatientModel patient;

  const VitalsNotesPage({super.key, required this.patient});

  @override
  State<VitalsNotesPage> createState() => _VitalsNotesPageState();
}

class _VitalsNotesPageState extends State<VitalsNotesPage> {
  List<ConsultationModel> _consultations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final provider = context.read<DoctorProvider>();
    final results = await provider.fetchPatientConsultations(widget.patient.id);
    if (mounted) {
      setState(() {
        _consultations = results;
        _isLoading = false;
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final parsed = DateTime.parse(dateStr);
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final latestConsult = _consultations.isNotEmpty ? _consultations.first : null;

    final tempVal = latestConsult != null ? formatNum(latestConsult.temperature) : '36.8';
    final weightVal = latestConsult != null
        ? '${formatNum(latestConsult.poids)} kg'
        : (widget.patient.weight.contains('kg') ? widget.patient.weight : '${widget.patient.weight} kg');
    final heightVal = latestConsult != null
        ? '${formatNum(latestConsult.taille)} cm'
        : (widget.patient.height.contains('cm') ? widget.patient.height : '${widget.patient.height} cm');

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        title: const Text('Patient Vitals & Notes',
            style: TextStyle(
                color: kDark,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: kTeal))
          : RefreshIndicator(
              color: kTeal,
              onRefresh: _fetchHistory,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Current Vitals ────────────────────────────
                    _sectionCard(
                      icon: Icons.monitor_heart_outlined,
                      title: 'Current Vitals',
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: _vitalBox(
                                'Heart Rate',
                                '82',
                                'BPM',
                                kTeal,
                                const Color(0xFFE0F2F1),
                                Icons.favorite_outline,
                                isNormal: true,
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: _vitalBox(
                                'SpO2',
                                '98',
                                '%',
                                const Color(0xFF2196F3),
                                const Color(0xFFE3F2FD),
                                Icons.air,
                                isNormal: true,
                              )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                  child: _vitalBox(
                                'Temp',
                                tempVal,
                                '°C',
                                const Color(0xFFFF9800),
                                const Color(0xFFFFF3E0),
                                Icons.thermostat_outlined,
                                isNormal: true,
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: _vitalBox(
                                'Weight',
                                weightVal,
                                '',
                                kTeal,
                                const Color(0xFFE0F2F1),
                                Icons.monitor_weight_outlined,
                                isNormal: true,
                              )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                  child: _vitalBox(
                                'Height',
                                heightVal,
                                '',
                                const Color(0xFF9C27B0),
                                const Color(0xFFF3E5F5),
                                Icons.height,
                                isNormal: true,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Notes from consultations ─────────────────────
                    _sectionCard(
                      icon: Icons.note_alt_outlined,
                      title: 'Notes from consultations',
                      child: _consultations.isEmpty
                          ? const Text('No notes recorded yet.', style: TextStyle(color: kGrey, fontSize: 13))
                          : Column(
                              children: _consultations.map((c) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: _noteItem(
                                    'Consultation on ${_formatDate(c.dateConsultation)}',
                                    c.observation.isNotEmpty ? c.observation : 'No observation notes.',
                                  ),
                                );
                              }).toList(),
                            ),
                    ),

                    const SizedBox(height: 16),

                    // ── Allergies & Medical History ───────────────────────────
                    _sectionCard(
                      icon: Icons.history_outlined,
                      title: 'Allergies & Medical History',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.patient.allergies.isEmpty && widget.patient.medicalHistory.isEmpty)
                            const Text('No medical history or allergies recorded.', style: TextStyle(color: kGrey, fontSize: 13)),
                          if (widget.patient.allergies.isNotEmpty) ...[
                            const Text('Allergies:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: kDark)),
                            const SizedBox(height: 6),
                            ...widget.patient.allergies.map((a) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _historyItem(
                                a,
                                'Allergic reaction',
                                const Color(0xFFFFEBEE),
                                kRed,
                              ),
                            )),
                            const SizedBox(height: 12),
                          ],
                          if (widget.patient.medicalHistory.isNotEmpty) ...[
                            const Text('Antécédents / History:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: kDark)),
                            const SizedBox(height: 6),
                            ...widget.patient.medicalHistory.map((h) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _historyItem(
                                h,
                                'Recorded Medical Event',
                                const Color(0xFFE3F2FD),
                                const Color(0xFF2196F3),
                              ),
                            )),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  // ── Section card wrapper ────────────────────────────
  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 8,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kTeal, size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: kDark)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ── Vital box ───────────────────────────────────────
  Widget _vitalBox(String label, String value, String unit,
      Color color, Color bgColor, IconData icon,
      {required bool isNormal}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: kGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
              Icon(icon, color: color, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: TextStyle(
                      color: color,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(unit,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isNormal
                  ? const Color(0xFF4CAF50).withOpacity(0.15)
                  : kRed.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isNormal ? 'Normal' : 'High',
              style: TextStyle(
                  color: isNormal ? const Color(0xFF4CAF50) : kRed,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ── Note item ───────────────────────────────────────
  Widget _noteItem(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(
            color: kTeal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: kDark)),
              Text(subtitle,
                  style: const TextStyle(
                      color: kGrey, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  // ── History item ────────────────────────────────────
  Widget _historyItem(
      String title, String subtitle, Color bgColor, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: kDark)),
                Text(subtitle,
                    style: const TextStyle(
                        color: kGrey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}