// lib/models/doctor_models.dart

/// Formats a [double] cleanly: removes unnecessary trailing zeros.
/// Examples: 12.0 → "12", 12.50 → "12.5", 120.0 → "120", 37.5 → "37.5"
String formatNum(double value) {
  if (value == value.truncateToDouble()) {
    return value.toInt().toString();
  }
  // Up to 2 decimal places, trim trailing zeros
  String s = value.toStringAsFixed(2);
  s = s.replaceAll(RegExp(r'0+$'), '');
  if (s.endsWith('.')) s = s.substring(0, s.length - 1);
  return s;
}


class PatientModel {
  final String id;
  final String name;
  final String age;
  final String gender;
  final String weight;
  final String height;
  final String status;
  final String lastVisit;
  final String condition;
  final String photoUrl;
  final String parentName;
  final String parentRelation;
  final String parentPhone;
  final String parentEmail;
  final List<String> medicalHistory;
  final List<String> allergies;
  final String bloodType;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.status,
    required this.lastVisit,
    required this.condition,
    required this.photoUrl,
    required this.parentName,
    required this.parentRelation,
    required this.parentPhone,
    required this.parentEmail,
    required this.medicalHistory,
    required this.allergies,
    required this.bloodType,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '${json['first_name'] ?? ''} ${json['last_name'] ?? ''}'.trim(),
      age: json['birth_date'] != null 
          ? '${_calculateAge(json['birth_date'])} years old' 
          : (json['age']?.toString() ?? 'N/A'),
      gender: json['gender'] == 'M' ? 'Male' : (json['gender'] == 'F' ? 'Female' : (json['gender'] ?? 'N/A')),
      weight: json['weight']?.toString() ?? (json['poids']?.toString() ?? 'N/A'),
      height: json['height']?.toString() ?? (json['taille']?.toString() ?? 'N/A'),
      status: json['status'] ?? 'ACTIVE',
      lastVisit: json['last_visit'] ?? json['lastVisit'] ?? '',
      condition: json['condition'] ?? 'Stable',
      photoUrl: json['photo_url'] ?? json['photoUrl'] ?? 'https://i.pravatar.cc/150?img=12',
      parentName: json['parent_name'] ?? json['parentName'] ?? 'Parent',
      parentRelation: json['parent_relation'] ?? json['parentRelation'] ?? 'Mère',
      parentPhone: json['telephone_parent'] ?? json['parentPhone'] ?? '',
      parentEmail: json['email'] ?? json['parentEmail'] ?? '',
      medicalHistory: List<String>.from(json['medical_history'] ?? json['medicalHistory'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
      bloodType: json['groupe_sanguin'] ?? json['bloodType'] ?? 'O+',
    );
  }

  static int _calculateAge(String birthDateStr) {
    try {
      final birthDate = DateTime.parse(birthDateStr);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return 0;
    }
  }
}

class AppointmentModel {
  final String id;
  final String doctorName;
  final String patientName;
  final String patientId; // Kept for UI logic
  final String dateRdv;
  final String dateKey; // UI filtering e.g. '2026-04-26'
  final String time; // UI display time
  final String type; // Replaces reason/motif in UI for now
  final String status;
  final String statusLabel;

  AppointmentModel({
    required this.id,
    required this.doctorName,
    required this.patientName,
    required this.patientId,
    required this.dateRdv,
    required this.dateKey,
    required this.time,
    required this.type,
    required this.status,
    required this.statusLabel,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    // Standardize backend date_rdv ('YYYY-MM-DDTHH:MM:SSZ' or 'YYYY-MM-DD')
    final rawDate = json['date_rdv'] ?? '';
    String parsedDateKey = '';
    try {
      if (rawDate.isNotEmpty) {
        parsedDateKey = rawDate.split('T')[0];
      }
    } catch (_) {}

    return AppointmentModel(
      id: json['id']?.toString() ?? '',
      doctorName: json['doctor'] ?? 'Dr. James Wilson',
      patientName: json['patient'] ?? 'Unknown Patient',
      patientId: json['patient_id']?.toString() ?? '',
      dateRdv: rawDate,
      dateKey: parsedDateKey.isNotEmpty ? parsedDateKey : (json['dateKey'] ?? ''),
      time: json['heure'] ?? '09:00 AM',
      type: json['motif'] ?? 'Routine Checkup',
      status: json['status'] ?? 'PENDING',
      statusLabel: json['status_label'] ?? 'En attente',
    );
  }
}

class TraitementModel {
  final String id;
  final String medicament;
  final String dose;
  final String duree;
  final String instructions;

  TraitementModel({
    required this.id,
    required this.medicament,
    required this.dose,
    required this.duree,
    required this.instructions,
  });

  factory TraitementModel.fromJson(Map<String, dynamic> json) {
    return TraitementModel(
      id: json['id']?.toString() ?? '',
      medicament: json['medicament'] ?? '',
      dose: json['dose'] ?? '',
      duree: json['duree'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }
}

class DiagnosticModel {
  final String id;
  final String nomMaladie;
  final String typeMaladie;
  final String typeLabel;
  final String gravite;
  final String graviteLabel;
  final String commentaireMedical;
  final String explicationParent;

  DiagnosticModel({
    required this.id,
    required this.nomMaladie,
    required this.typeMaladie,
    required this.typeLabel,
    required this.gravite,
    required this.graviteLabel,
    required this.commentaireMedical,
    required this.explicationParent,
  });

  factory DiagnosticModel.fromJson(Map<String, dynamic> json) {
    return DiagnosticModel(
      id: json['id']?.toString() ?? '',
      nomMaladie: json['nom_maladie'] ?? '',
      typeMaladie: json['type_maladie'] ?? '',
      typeLabel: json['type_label'] ?? 'Diagnostic',
      gravite: json['gravite'] ?? '',
      graviteLabel: json['gravite_label'] ?? 'Stable',
      commentaireMedical: json['commentaire_medical'] ?? '',
      explicationParent: json['explication_parent'] ?? '',
    );
  }
}

class ConsultationModel {
  final String id;
  final String appointmentId;
  final String patientName;
  final String dateConsultation;
  final double poids;
  final double taille;
  final double temperature;
  final String observation;
  final List<DiagnosticModel> diagnostics;
  final List<TraitementModel> traitements;

  ConsultationModel({
    required this.id,
    required this.appointmentId,
    required this.patientName,
    required this.dateConsultation,
    required this.poids,
    required this.taille,
    required this.temperature,
    required this.observation,
    required this.diagnostics,
    required this.traitements,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    var diagList = json['diagnostics'] as List? ?? [];
    var traitList = json['traitements'] as List? ?? [];

    return ConsultationModel(
      id: json['id']?.toString() ?? '',
      appointmentId: json['appointment_id']?.toString() ?? '',
      patientName: json['patient'] ?? '',
      dateConsultation: json['date_consultation'] ?? '',
      poids: double.tryParse(json['poids']?.toString() ?? '0.0') ?? 0.0,
      taille: double.tryParse(json['taille']?.toString() ?? '0.0') ?? 0.0,
      temperature: double.tryParse(json['temperature']?.toString() ?? '0.0') ?? 0.0,
      observation: json['observation'] ?? '',
      diagnostics: diagList.map((d) => DiagnosticModel.fromJson(d)).toList(),
      traitements: traitList.map((t) => TraitementModel.fromJson(t)).toList(),
    );
  }
}

String formatDateString(String rawDate) {
  if (rawDate.isEmpty) return '';
  try {
    final dateTime = DateTime.parse(rawDate).toLocal();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  } catch (_) {
    return rawDate;
  }
}

class DocumentModel {
  final String id;
  final String patientId;
  final String? consultationId;
  final String nomFichier;
  final String typeDoc;
  final String typeDocDisplay;
  final String fichier;
  final String urlStockage;
  final String dateUpload;
  final String dateConsultation;

  DocumentModel({
    required this.id,
    required this.patientId,
    this.consultationId,
    required this.nomFichier,
    required this.typeDoc,
    required this.typeDocDisplay,
    required this.fichier,
    required this.urlStockage,
    required this.dateUpload,
    required this.dateConsultation,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id']?.toString() ?? '',
      patientId: json['patient']?.toString() ?? '',
      consultationId: json['consultation']?.toString(),
      nomFichier: json['nom_fichier'] ?? '',
      typeDoc: json['type_doc'] ?? 'AUTRE',
      typeDocDisplay: json['type_doc_display'] ?? 'Autre',
      fichier: json['fichier'] ?? '',
      urlStockage: json['url_stockage'] ?? '',
      dateUpload: json['date_upload'] ?? '',
      dateConsultation: json['date_consultation'] ?? json['date_upload'] ?? '',
    );
  }
}
