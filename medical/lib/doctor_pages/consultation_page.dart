// lib/doctor_pages/consultation_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical/models/doctor_models.dart';
import 'package:medical/providers/doctor_provider.dart';

const Color kTeal  = Color(0xFF4DB6AC);
const Color kBg    = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kDark  = Color(0xFF1A1A2E);
const Color kGrey  = Color(0xFF9E9E9E);

class ConsultationPage extends StatefulWidget {
  final PatientModel patient;
  final AppointmentModel appointment;

  const ConsultationPage({
    super.key,
    required this.patient,
    required this.appointment,
  });

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  // Vitals
  late TextEditingController _weightCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _tempCtrl;
  late TextEditingController _observationCtrl;

  // Diagnostic
  late TextEditingController _maladieNameCtrl;
  String _selectedType    = 'AUTRE';
  String _selectedGravite = 'LEGERE';
  late TextEditingController _commentCtrl;

  // Prescriptions (multiple treatments)
  // Each entry is a map with controllers: {medicament, dose, duree}
  final List<Map<String, TextEditingController>> _treatments = [];

  /// true  = appointment is COMPLETED and we are in read-only / view-summary mode
  /// false = new consultation OR edit mode
  bool _isReadOnly = false;

  /// Switches to true when the doctor taps "Edit" on a completed consultation
  bool _isEditing = false;

  bool _isLoadingConsultation = false;


  @override
  void initState() {
    super.initState();

    _isReadOnly = widget.appointment.status == 'COMPLETED';

    _weightCtrl = TextEditingController(
      text: widget.patient.weight.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    _heightCtrl = TextEditingController(
      text: widget.patient.height.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    _tempCtrl        = TextEditingController(text: '37.0');
    _observationCtrl = TextEditingController(text: 'Patient parameters checked.');
    _maladieNameCtrl = TextEditingController();
    _commentCtrl     = TextEditingController();

    // Start with one empty treatment row
    _addTreatmentRow();

    if (_isReadOnly) {
      _isLoadingConsultation = true;
      _loadConsultationData();
    }
  }

  Future<void> _loadConsultationData() async {
    try {
      final list = await context
          .read<DoctorProvider>()
          .fetchPatientConsultations(widget.patient.id);

      final consult = list.firstWhere(
        (c) => c.appointmentId == widget.appointment.id,
      );

      setState(() {
        _weightCtrl.text      = formatNum(consult.poids);
        _heightCtrl.text      = formatNum(consult.taille);
        _tempCtrl.text        = formatNum(consult.temperature);
        _observationCtrl.text = consult.observation;

        if (consult.diagnostics.isNotEmpty) {
          final diag = consult.diagnostics.first;
          _maladieNameCtrl.text = diag.nomMaladie;
          _selectedType         = diag.typeMaladie;
          _selectedGravite      = diag.gravite;
          _commentCtrl.text     = diag.commentaireMedical;
        }

        if (consult.traitements.isNotEmpty) {
          // Clear default empty row first
          for (final row in _treatments) {
            row.forEach((_, ctrl) => ctrl.dispose());
          }
          _treatments.clear();
          for (final trait in consult.traitements) {
            _addTreatmentRow(
              medicament: trait.medicament,
              dose:       trait.dose,
              duree:      trait.duree,
            );
          }
          if (_treatments.isEmpty) _addTreatmentRow();
        }

        _isLoadingConsultation = false;
      });
    } catch (e) {
      debugPrint('Error loading consultation: $e');
      setState(() => _isLoadingConsultation = false);
    }
  }

  void _addTreatmentRow({
    String medicament = '',
    String dose = '',
    String duree = '',
  }) {
    _treatments.add({
      'medicament': TextEditingController(text: medicament),
      'dose':       TextEditingController(text: dose),
      'duree':      TextEditingController(text: duree),
    });
  }

  void _removeTreatmentRow(int index) {
    if (_treatments.length > 1) {
      _treatments[index].forEach((_, ctrl) => ctrl.dispose());
      setState(() => _treatments.removeAt(index));
    }
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    _tempCtrl.dispose();
    _observationCtrl.dispose();
    _maladieNameCtrl.dispose();
    _commentCtrl.dispose();
    for (final row in _treatments) {
      row.forEach((_, ctrl) => ctrl.dispose());
    }
    super.dispose();
  }

  // ── Submission handlers ─────────────────────────────────────────────────────

  /// Called when completing a new (non-COMPLETED) appointment
  Future<void> _handleFinishSession() async {
    if (_maladieNameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the Maladie (disease) name.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final provider = context.read<DoctorProvider>();
    final traitements = _treatments
        .where((row) => (row['medicament']?.text.trim() ?? '').isNotEmpty)
        .map((row) => {
              'medicament': row['medicament']!.text.trim(),
              'dose': row['dose']!.text.trim(),
              'duree': row['duree']!.text.trim(),
            })
        .toList();

    final success = await provider.completeConsultation(
      appointmentId:      widget.appointment.id,
      weight:             double.tryParse(_weightCtrl.text) ?? 20.0,
      height:             double.tryParse(_heightCtrl.text) ?? 110.0,
      temperature:        double.tryParse(_tempCtrl.text) ?? 37.0,
      observation:        _observationCtrl.text.trim(),
      nomMaladie:         _maladieNameCtrl.text.trim(),
      typeMaladie:        _selectedType,
      gravite:            _selectedGravite,
      commentaireMedical: _commentCtrl.text.trim(),
      traitements:        traitements,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Consultation saved successfully! Patient updated.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving consultation. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Called when saving edits to an already-COMPLETED consultation
  Future<void> _handleUpdateConsultation() async {
    if (_maladieNameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the Maladie (disease) name.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final provider = context.read<DoctorProvider>();
    final traitements = _treatments
        .where((row) => (row['medicament']?.text.trim() ?? '').isNotEmpty)
        .map((row) => {
              'medicament': row['medicament']!.text.trim(),
              'dose': row['dose']!.text.trim(),
              'duree': row['duree']!.text.trim(),
            })
        .toList();

    final success = await provider.updateConsultation(
      appointmentId:      widget.appointment.id,
      weight:             double.tryParse(_weightCtrl.text) ?? 20.0,
      height:             double.tryParse(_heightCtrl.text) ?? 110.0,
      temperature:        double.tryParse(_tempCtrl.text) ?? 37.0,
      observation:        _observationCtrl.text.trim(),
      nomMaladie:         _maladieNameCtrl.text.trim(),
      typeMaladie:        _selectedType,
      gravite:            _selectedGravite,
      commentaireMedical: _commentCtrl.text.trim(),
      traitements:        traitements,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Consultation updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => _isEditing = false);
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update consultation. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool get _fieldsEnabled => !_isReadOnly || _isEditing;

  @override
  Widget build(BuildContext context) {
    final bool showReadOnly = _isReadOnly && !_isEditing;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        title: Text(
          showReadOnly
              ? 'Consultation Summary'
              : _isEditing
                  ? 'Edit Consultation'
                  : 'Active Consultation',
          style: const TextStyle(
              color: kDark, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDark),
          onPressed: () {
            if (_isEditing) {
              setState(() => _isEditing = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          // Show "Edit" button when viewing a completed consultation summary
          if (showReadOnly && !_isLoadingConsultation)
            TextButton.icon(
              onPressed: () => setState(() => _isEditing = true),
              icon: const Icon(Icons.edit, color: kTeal, size: 18),
              label: const Text('Edit',
                  style: TextStyle(
                      color: kTeal, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      body: _isLoadingConsultation
          ? const Center(child: CircularProgressIndicator(color: kTeal))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Patient Info Banner ──────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [kTeal, Color(0xFF26A69A)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              NetworkImage(widget.patient.photoUrl),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.patient.name,
                                  style: const TextStyle(
                                      color: kWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                'Appointment Date: ${widget.appointment.dateRdv}',
                                style: const TextStyle(
                                    color: Color(0xCCFFFFFF), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        // Edit indicator chip
                        if (_isEditing)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.orange, width: 1),
                            ),
                            child: const Text('EDITING',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Vitals ──────────────────────────────────────────────
                  const Text('Patient Current Vitals',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kDark)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: _vitalsField(_weightCtrl, 'Weight (kg)',
                              Icons.monitor_weight_outlined)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _vitalsField(
                              _heightCtrl, 'Height (cm)', Icons.height)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _vitalsField(
                              _tempCtrl, 'Temp (°C)', Icons.thermostat)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Observations ─────────────────────────────────────────
                  const Text('Subjective Observations',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kDark)),
                  const SizedBox(height: 8),
                  _clinicalTextField(_observationCtrl, 3,
                      'Enter general assessment or clinical observations...'),
                  const SizedBox(height: 20),

                  // ── Diagnostics ─────────────────────────────────────────
                  const Text('Objective Findings & Diagnostics',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kDark)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _maladieNameCtrl,
                          enabled: _fieldsEnabled,
                          decoration: const InputDecoration(
                            labelText: 'Maladie Name *',
                            hintText: 'e.g., Bronchite',
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (_fieldsEnabled) ...[
                          DropdownButtonFormField<String>(
                            initialValue: _selectedType,
                            items: [
                              'AIGU',
                              'CHRONIQUE',
                              'ALLERGIQUE',
                              'INFECTIEUX',
                              'AUTRE',
                            ]
                                .map((t) => DropdownMenuItem(
                                    value: t, child: Text(t)))
                                .toList(),
                            onChanged: (val) => setState(
                                () => _selectedType = val ?? 'AUTRE'),
                            decoration: const InputDecoration(
                                labelText: 'Maladie Classification'),
                          ),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedGravite,
                            items: ['LEGERE', 'MODEREE', 'SEVERE']
                                .map((g) => DropdownMenuItem(
                                    value: g, child: Text(g)))
                                .toList(),
                            onChanged: (val) => setState(
                                () => _selectedGravite = val ?? 'LEGERE'),
                            decoration: const InputDecoration(
                                labelText: 'Severity Index'),
                          ),
                        ] else
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Composite: ${_maladieNameCtrl.text} • $_selectedType • $_selectedGravite',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _commentCtrl,
                          enabled: _fieldsEnabled,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Medical Comments',
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Treatment (optional, multiple) ──────────────────────
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Prescribed Treatments',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: kDark)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Optional',
                            style: TextStyle(color: kTeal, fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Column(
                      children: [
                        ...List.generate(_treatments.length, (i) {
                          final row = _treatments[i];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFEEEEEE)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Medication ${i + 1}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: kTeal,
                                        ),
                                      ),
                                    ),
                                    if (_fieldsEnabled && _treatments.length > 1)
                                      InkWell(
                                        onTap: () => _removeTreatmentRow(i),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: row['medicament'],
                                  enabled: _fieldsEnabled,
                                  decoration: const InputDecoration(
                                    labelText: 'Medication Name',
                                    hintText: 'e.g. Paracetamol',
                                    isDense: true,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: row['dose'],
                                        enabled: _fieldsEnabled,
                                        decoration: const InputDecoration(
                                          labelText: 'Dose',
                                          hintText: 'e.g. 500mg',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller: row['duree'],
                                        enabled: _fieldsEnabled,
                                        decoration: const InputDecoration(
                                          labelText: 'Duration',
                                          hintText: 'e.g. 5 jours',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        if (_fieldsEnabled)
                          TextButton.icon(
                            onPressed: () => setState(() => _addTreatmentRow()),
                            icon: const Icon(Icons.add_circle_outline,
                                color: kTeal, size: 18),
                            label: const Text(
                              '+ Add Medication',
                              style: TextStyle(
                                color: kTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),


                  // ── Bottom Actions ───────────────────────────────────────
                  Consumer<DoctorProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: kTeal),
                        );
                      }

                      // View Summary (read-only, not editing)
                      if (showReadOnly) {
                        return Center(
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.check_circle_outline,
                                color: kWhite),
                            label: const Text('Close Summary',
                                style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        );
                      }

                      // Edit mode — save edits to backend
                      if (_isEditing) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: _handleUpdateConsultation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save, color: kWhite),
                                  SizedBox(width: 8),
                                  Text('Finish Session & Save',
                                      style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () => setState(() => _isEditing = false),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: kGrey),
                                minimumSize: const Size(double.infinity, 46),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Discard Changes',
                                  style: TextStyle(color: kGrey)),
                            ),
                          ],
                        );
                      }

                      // New consultation — submit to backend
                      return ElevatedButton(
                        onPressed: _handleFinishSession,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kTeal,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Finish Session',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  // ── Field builders ──────────────────────────────────────────────────────────

  Widget _vitalsField(
      TextEditingController ctrl, String label, IconData icon) {
    return TextField(
      controller: ctrl,
      enabled: _fieldsEnabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 16, color: kTeal),
        filled: true,
        fillColor: kWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }

  Widget _clinicalTextField(
      TextEditingController ctrl, int lines, String hint) {
    return TextField(
      controller: ctrl,
      maxLines: lines,
      enabled: _fieldsEnabled,
      style: const TextStyle(fontSize: 13, color: kDark),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: kWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }
}
