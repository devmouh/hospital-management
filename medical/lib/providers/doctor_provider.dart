// lib/providers/doctor_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/doctor_models.dart';
import '../services/api_service.dart';

class DoctorProvider extends ChangeNotifier {
  // ── State ───────────────────────────────────────────────────────────
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PatientModel> _patients = [];
  List<AppointmentModel> _appointments = [];

  List<PatientModel> get patients => _patients;
  List<AppointmentModel> get appointments => _appointments;

  // Stats from backend Dashboard View
  int _totalAppointmentsCount = 0;
  int _pendingCount = 0;
  int _confirmedCount = 0;
  int _completedCount = 0;
  int _cancelledCount = 0;

  int get totalAppointmentsCount => _totalAppointmentsCount;
  int get pendingCount => _pendingCount;
  int get confirmedCount => _confirmedCount;
  int get completedCount => _completedCount;
  int get cancelledCount => _cancelledCount;

  // Active Doctor Information (fetched from API, with sensible defaults)
  String doctorName = 'Dr. James Wilson';
  String doctorBio = "Pediatrician • St. Mary's Hospital";
  String? doctorPhotoUrl;
  String doctorEmail = 'amrani@hopital-oran.dz';
  String doctorPhone = '0555111111';
  String doctorLocation = 'Oran, Algeria';
  String doctorWorkingHours = '08:00 AM - 05:00 PM';

  // ── Initialization ──────────────────────────────────────────────────
  DoctorProvider() {
    // On startup, fetch all data from backend.
    // If the backend is unreachable we fall back to mock data automatically.
    fetchAllData();
  }

  // ── Public entry point ───────────────────────────────────────────────
  Future<void> fetchAllData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _patients.clear();

      // Run all four fetches in parallel for speed
      await Future.wait([
        _fetchDashboard(),
        _fetchAppointments(),
        _fetchPatients(),
        _fetchProfile(),
      ]);

      // Safely build stubs for any missing patients referenced in appointments
      for (final appt in _appointments) {
        if (!_patients.any((p) => p.id == appt.patientId)) {
          _patients.add(
            PatientModel(
              id: appt.patientId,
              name: appt.patientName,
              age: 'Unknown age',
              gender: 'N/A',
              weight: 'N/A',
              height: 'N/A',
              status: 'ACTIVE',
              lastVisit: appt.dateRdv,
              condition: 'Stable',
              photoUrl: 'https://i.pravatar.cc/150?img=10',
              parentName: 'Parent',
              parentRelation: 'Mère',
              parentPhone: '',
              parentEmail: '',
              medicalHistory: [],
              allergies: [],
              bloodType: 'O+',
            ),
          );
        }
      }
    } catch (e) {
      // Backend unreachable → fall back to static mock data
      debugPrint('❗ Backend unreachable – loading mock data: $e');
      _loadMockData();
      return; // _loadMockData already sets _isLoading = false and notifies
    }

    _isLoading = false;
    notifyListeners();
  }

  // ── Individual fetchers (private) ────────────────────────────────────

  Future<void> _fetchDashboard() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/doctor/dashboard/'),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _totalAppointmentsCount = data['total_appointments'] ?? 0;
        _pendingCount = data['pending'] ?? 0;
        _confirmedCount = data['confirmed'] ?? 0;
        _completedCount = data['completed'] ?? 0;
        _cancelledCount = data['cancelled'] ?? 0;
      } else {
        debugPrint(
          'Dashboard API returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching dashboard: $e');
    }
  }

  Future<void> _fetchPatients() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/doctor/patients/'),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rawList = data['patients'] as List? ?? [];
        _patients = rawList
            .map((item) => PatientModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint(
          'Patients API returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching patients: $e');
      rethrow;
    }
  }

  Future<void> _fetchAppointments() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/doctor/appointments/'),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rawList = data['appointments'] as List? ?? [];

        _appointments = rawList
            .map(
              (item) => AppointmentModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();

        // Refresh dashboard counts from live appointments when dashboard endpoint not available
        if (_totalAppointmentsCount == 0) {
          _totalAppointmentsCount = _appointments.length;
          _pendingCount = _appointments
              .where((a) => a.status == 'waiting' || a.status == 'PENDING')
              .length;
          _completedCount = _appointments
              .where((a) => a.status == 'completed' || a.status == 'COMPLETED')
              .length;
        }
      } else {
        debugPrint(
          'Appointments API returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching appointments: $e');
    }
  }

  Future<List<ConsultationModel>> fetchPatientConsultations(
    String patientId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiService.baseUrl}/api/doctor/consultations/?patient_id=$patientId',
        ),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rawList = data['consultations'] as List? ?? [];
        return rawList
            .map(
              (item) =>
                  ConsultationModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        debugPrint(
          'Consultations API returned ${response.statusCode}: ${response.body}',
        );
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching patient consultations: $e');
      return [];
    }
  }

  Future<List<DocumentModel>> fetchPatientDocuments(String patientId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/documents/patient/$patientId/'),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => DocumentModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint(
          'Documents API returned ${response.statusCode}: ${response.body}',
        );
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching patient documents: $e');
      return [];
    }
  }

  Future<void> _fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/doctor/profile/'),
        headers: ApiService.getHeaders(),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        doctorName =
            'Dr. ${data['first_name'] ?? ''} ${data['last_name'] ?? ''}'.trim();
        doctorBio = data['bio'] ?? '';
        if (doctorBio.isEmpty) {
          doctorBio =
              '${data['specialty']?['name'] ?? 'Doctor'} • ${data['ville'] ?? "Hopital d\'Oran"}';
        }
        doctorPhotoUrl = data['photo'] as String?;
        doctorEmail = data['email'] ?? '';
        doctorPhone = data['phone'] ?? '';
        doctorLocation = data['ville'] ?? '';
        doctorWorkingHours = data['horaire_travail'] ?? '';
      } else {
        debugPrint(
          'Profile API returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    }
  }

  Future<bool> updateProfile({
    required String phone,
    required String ville,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiService.baseUrl}/api/doctor/profile/'),
        headers: ApiService.getHeaders(),
        body: jsonEncode({'phone': phone, 'ville': ville}),
      );
      if (response.statusCode == 200) {
        doctorPhone = phone;
        doctorLocation = ville;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
    }
    return false;
  }

  Future<bool> updateWorkingHours(String hours) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiService.baseUrl}/api/doctor/profile/'),
        headers: ApiService.getHeaders(),
        body: jsonEncode({'horaire_travail': hours}),
      );
      if (response.statusCode == 200) {
        doctorWorkingHours = hours;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Error updating working hours: $e');
    }
    return false;
  }

  // ── Mock / offline fallback ──────────────────────────────────────────
  void _loadMockData() {
    _patients = [
      PatientModel(
        id: 'P001',
        name: 'Ahmed issa',
        age: '6 years old',
        gender: 'Male',
        weight: '22 kg',
        height: '120 cm',
        status: 'ACTIVE',
        lastVisit: 'Apr 20, 2026',
        condition: 'Stable',
        photoUrl: 'https://i.pravatar.cc/150?img=13',
        parentName: 'iyad meriem',
        parentRelation: 'Mère',
        parentPhone: '+213 555 123 456',
        parentEmail: 'iyadmeriem@email.com',
        medicalHistory: [
          'Seasonal Allergies',
          'Asthma Diagnosis',
          'Surgery: Tonsillectomy',
        ],
        allergies: ['Pollen', 'Dust', 'Penicillin'],
        bloodType: 'A+',
      ),
      PatientModel(
        id: 'P002',
        name: 'Issaoui Youcef',
        age: '8 years old',
        gender: 'Male',
        weight: '28 kg',
        height: '132 cm',
        status: 'ACTIVE',
        lastVisit: 'Apr 24, 2026',
        condition: 'Recovery',
        photoUrl: 'https://i.pravatar.cc/150?img=12',
        parentName: 'Issaoui Houari',
        parentRelation: 'Père',
        parentPhone: '+213 555 234 567',
        parentEmail: 'Issaoui.Houari@email.com',
        medicalHistory: ['Broken Arm', 'Routine Vaccination'],
        allergies: ['Latex'],
        bloodType: 'O+',
      ),
      PatientModel(
        id: 'P003',
        name: 'Driss Maria',
        age: '5 years old',
        gender: 'Female',
        weight: '18 kg',
        height: '110 cm',
        status: 'ACTIVE',
        lastVisit: 'Apr 25, 2026',
        condition: 'Stable',
        photoUrl: 'https://i.pravatar.cc/150?img=34',
        parentName: 'Laid Fatima',
        parentRelation: 'Mère',
        parentPhone: '+213 555 345 678',
        parentEmail: 'sofia.garcia@email.com',
        medicalHistory: ['Vaccination – MMR', 'Eczema – Mild'],
        allergies: ['Nuts', 'Shellfish'],
        bloodType: 'B+',
      ),
      PatientModel(
        id: 'P004',
        name: 'Benkhadda Walid',
        age: '3 years old',
        gender: 'Male',
        weight: '14 kg',
        height: '98 cm',
        status: 'NEW',
        lastVisit: 'Apr 26, 2026',
        condition: 'Managing',
        photoUrl: 'https://i.pravatar.cc/150?img=68',
        parentName: 'Draoui Lamia',
        parentRelation: 'Mère',
        parentPhone: '+213 555 456 789',
        parentEmail: 'Draoui.Lamia@email.com',
        medicalHistory: ['Fever Episodes', 'First Visit'],
        allergies: ['Dairy'],
        bloodType: 'AB+',
      ),
      PatientModel(
        id: 'P005',
        name: 'Khither Rania',
        age: '4 years old',
        gender: 'Female',
        weight: '16 kg',
        height: '103 cm',
        status: 'ACTIVE',
        lastVisit: 'Apr 22, 2026',
        condition: 'Stable',
        photoUrl: 'https://i.pravatar.cc/150?img=49',
        parentName: 'Khither Toufik',
        parentRelation: 'Père',
        parentPhone: '+213 555 567 890',
        parentEmail: 'khither.toufik@email.com',
        medicalHistory: [],
        allergies: [],
        bloodType: 'A-',
      ),
    ];

    _appointments = [
      AppointmentModel(
        id: 'A001',
        patientId: 'P001',
        patientName: 'Ahmed issa',
        doctorName: 'Dr. James Wilson',
        type: 'Routine Checkup',
        time: '08:30 AM',
        dateRdv: 'Apr 26, 2026',
        dateKey: '2026-04-26',
        status: 'completed',
        statusLabel: 'Terminé',
      ),
      AppointmentModel(
        id: 'A002',
        patientId: 'P002',
        patientName: 'Issaoui Youcef',
        doctorName: 'Dr. James Wilson',
        type: 'Immunization',
        time: '09:00 AM',
        dateRdv: 'Apr 26, 2026',
        dateKey: '2026-04-26',
        status: 'completed',
        statusLabel: 'Terminé',
      ),
      AppointmentModel(
        id: 'A003',
        patientId: 'P003',
        patientName: 'Driss Maria',
        doctorName: 'Dr. James Wilson',
        type: 'Fever Follow-up',
        time: '09:30 AM',
        dateRdv: 'Apr 26, 2026',
        dateKey: '2026-04-26',
        status: 'waiting',
        statusLabel: 'En attente',
      ),
      AppointmentModel(
        id: 'A004',
        patientId: 'P004',
        patientName: 'Benkhadda Walid',
        doctorName: 'Dr. James Wilson',
        type: 'First Consultation',
        time: '10:30 AM',
        dateRdv: 'Apr 26, 2026',
        dateKey: '2026-04-26',
        status: 'waiting',
        statusLabel: 'En attente',
      ),
    ];

    _totalAppointmentsCount = _appointments.length;
    _pendingCount = _appointments
        .where((a) => a.status == 'waiting' || a.status == 'PENDING')
        .length;
    _completedCount = _appointments
        .where((a) => a.status == 'completed' || a.status == 'COMPLETED')
        .length;

    _isLoading = false;
    notifyListeners();
  }

  // ── Public individual fetchers (for manual refresh from UI) ──────────
  Future<void> fetchDashboard() async => _fetchDashboard();
  Future<void> fetchAppointments() async => _fetchAppointments();
  Future<void> fetchPatients() async => _fetchPatients();
  Future<void> fetchProfile() async => _fetchProfile();

  String get todayDateKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  PatientModel getPatientById(String id) {
    return _patients.firstWhere(
      (p) => p.id == id,
      orElse: () => PatientModel(
        id: id,
        name: 'Patient #$id',
        age: 'Unknown',
        gender: 'N/A',
        weight: 'N/A',
        height: 'N/A',
        status: 'ACTIVE',
        lastVisit: '',
        condition: 'Stable',
        photoUrl: 'https://i.pravatar.cc/150?img=10',
        parentName: 'Parent',
        parentRelation: 'Mère',
        parentPhone: '',
        parentEmail: '',
        medicalHistory: [],
        allergies: [],
        bloodType: 'O+',
      ),
    );
  }

  List<AppointmentModel> getTodayAppointments() {
    return _appointments.where((a) => a.dateKey == todayDateKey).toList();
  }

  List<AppointmentModel> getAppointmentsByDate(String dateKey) {
    return _appointments.where((a) => a.dateKey == dateKey).toList();
  }

  int get getTotalPatientCount => _patients.length;

  int get getUpcomingAppointmentCount {
    return _appointments
        .where(
          (a) =>
              (a.status == 'waiting' ||
                  a.status == 'PENDING' ||
                  a.status == 'CONFIRMED') &&
              a.dateKey.compareTo(todayDateKey) >= 0,
        )
        .length;
  }

  List<PatientModel> get urgentPatients {
    return _patients
        .where((p) => p.condition.toLowerCase() != 'stable')
        .toList();
  }

  int get urgentCasesCount => urgentPatients.length;

  List<AppointmentModel> getUpcomingAppointments() {
    final today = todayDateKey;
    final list = _appointments.where((a) {
      final isFutureOrToday = a.dateKey.compareTo(today) >= 0;
      final isUpcomingStatus =
          a.status == 'waiting' ||
          a.status == 'PENDING' ||
          a.status == 'CONFIRMED';
      return isFutureOrToday && isUpcomingStatus;
    }).toList();

    // Sort chronologically (earliest first)
    list.sort((a, b) {
      final dateCompare = a.dateKey.compareTo(b.dateKey);
      if (dateCompare != 0) return dateCompare;
      return a.time.compareTo(b.time);
    });

    return list.take(6).toList();
  }

  // ── Toggle Appointment Status (PENDING ↔ CONFIRMED) ────────────────
  Future<bool> updateAppointmentStatus(String appointmentId, String newStatus) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiService.baseUrl}/api/doctor/appointments/'),
        headers: {
          ...ApiService.getHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'appointment_id': appointmentId,
          'status': newStatus,
        }),
      );
      if (response.statusCode == 200) {
        // Update the local list immediately
        final idx = _appointments.indexWhere((a) => a.id == appointmentId);
        if (idx != -1) {
          _appointments[idx] = AppointmentModel(
            id: _appointments[idx].id,
            patientId: _appointments[idx].patientId,
            patientName: _appointments[idx].patientName,
            doctorName: _appointments[idx].doctorName,
            type: _appointments[idx].type,
            time: _appointments[idx].time,
            dateRdv: _appointments[idx].dateRdv,
            dateKey: _appointments[idx].dateKey,
            status: newStatus,
            statusLabel: newStatus == 'CONFIRMED' ? 'Confirmé' : 'En attente',
          );
          notifyListeners();
        }
        return true;
      } else {
        debugPrint('Status update failed: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating appointment status: $e');
      return false;
    }
  }

  // ── Submit Complete Consultation ────────────────────────────────────
  Future<bool> completeConsultation({
    required String appointmentId,
    required double weight,
    required double height,
    required double temperature,
    required String observation,
    required String nomMaladie,
    required String typeMaladie,
    required String gravite,
    required String commentaireMedical,
    List<Map<String, String>> traitements = const [],
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> payload = {
        "consultation": {
          "poids": weight,
          "taille": height,
          "temperature": temperature,
          "observation": observation,
        },
        "diagnostic": {
          "nom_maladie": nomMaladie,
          "type_maladie": typeMaladie,
          "gravite": gravite,
          "commentaire_medical": commentaireMedical,
          "explication_parent": "",
        },
      };

      // Send multiple treatments as 'traitements' list
      if (traitements.isNotEmpty) {
        payload["traitements"] = traitements
            .map((t) => {
                  "medicament": t['medicament'] ?? '',
                  "dose": t['dose'] ?? '',
                  "duree": t['duree'] ?? '',
                  "instructions": "",
                })
            .toList();
      }

      final response = await http.post(
        Uri.parse(
          '${ApiService.baseUrl}/api/consultations/appointments/$appointmentId/complete/',
        ),
        headers: {
          ...ApiService.getHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 201) {
        await fetchAllData();
        return true;
      } else {
        debugPrint('Consultation execution failed: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error completing consultation: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ── Update / Edit Existing Consultation ─────────────────────────────
  Future<bool> updateConsultation({
    required String appointmentId,
    required double weight,
    required double height,
    required double temperature,
    required String observation,
    required String nomMaladie,
    required String typeMaladie,
    required String gravite,
    required String commentaireMedical,
    List<Map<String, String>> traitements = const [],
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> payload = {
        "consultation": {
          "poids": weight,
          "taille": height,
          "temperature": temperature,
          "observation": observation,
        },
        "diagnostic": {
          "nom_maladie": nomMaladie,
          "type_maladie": typeMaladie,
          "gravite": gravite,
          "commentaire_medical": commentaireMedical,
          "explication_parent": "",
        },
      };

      if (traitements.isNotEmpty) {
        payload["traitements"] = traitements
            .map((t) => {
                  "medicament": t['medicament'] ?? '',
                  "dose": t['dose'] ?? '',
                  "duree": t['duree'] ?? '',
                  "instructions": "",
                })
            .toList();
      }

      final response = await http.put(
        Uri.parse(
          '${ApiService.baseUrl}/api/consultations/appointments/$appointmentId/update/',
        ),
        headers: {
          ...ApiService.getHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Consultation update failed: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error updating consultation: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ── Secure Password Change Request ─────────────────────────────────────
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${ApiService.baseUrl}/api/doctor/change-password/',
        ), // Ensure this endpoint exists in Django
        headers: {
          ...ApiService.getHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Password changed successfully
      } else {
        debugPrint('Password update rejected: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Network error updating password: $e');
      return false;
    }
  }
}
