// ── All Patients (Updated Photos) ─────────────────────────────
// ============================================================
// app_data.dart  —  Single source of truth for all app data
// Place in: lib/generals/app_data.dart
// ============================================================

import 'package:flutter/material.dart';

// ── Patient model ─────────────────────────────────────────────
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

  const PatientModel({
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
}

// ── Appointment model ─────────────────────────────────────────
class AppointmentModel {
  final String id;
  final String patientId;
  final String type;
  final String time;
  final String date;        // e.g. 'Apr 26, 2026'
  final String dateKey;     // e.g. '2026-04-26' for filtering
  final String status;      // 'waiting' or 'completed'

  const AppointmentModel({
    required this.id,
    required this.patientId,
    required this.type,
    required this.time,
    required this.date,
    required this.dateKey,
    required this.status,
  });
}

// ── All Patients (Updated Photos by Age) ──────────────────────
const List<PatientModel> allPatients = [
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
      'Seasonal Allergies — Pollen, Dust (Moderate)',
      'Asthma Diagnosis — Last flare-up Oct 2023',
      'Surgery: Tonsillectomy — Jan 2022 (No complications)',
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
    medicalHistory: [
      'Broken Arm — Right radius fracture, Feb 2025',
      'Routine Vaccination — Up to date',
    ],
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
    medicalHistory: [
      'Vaccination — MMR complete',
      'Eczema — Mild, managed with cream',
    ],
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
    medicalHistory: [
      'Fever Episodes — Recurrent low-grade fever',
      'First Visit — New patient registration',
    ],
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
    medicalHistory: [
      'Immunization — Schedule up to date',
      'Ear Infection — Resolved March 2026',
    ],
    allergies: [],
    bloodType: 'A-',
  ),
  PatientModel(
    id: 'P006',
    name: 'Sidali Imad',
    age: '6 months old',
    gender: 'Male',
    weight: '7.5 kg',
    height: '67 cm',
    status: 'NEW',
    lastVisit: 'Apr 26, 2026',
    condition: 'Stable',
    photoUrl: 'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=150&h=150&auto=format&fit=crop',
    parentName: 'Kelthoumi Karima',
    parentRelation: 'Mère',
    parentPhone: '+213 555 678 901',
    parentEmail: 'Kelthoumi.Karima@email.com',
    medicalHistory: [
      'Routine Checkup — 6-month developmental assessment',
    ],
    allergies: [],
    bloodType: 'O-',
  ),
  PatientModel(
    id: 'P007',
    name: 'Ali Sara ',
    age: '2 years old',
    gender: 'Female',
    weight: '12 kg',
    height: '88 cm',
    status: 'NEW',
    lastVisit: 'Apr 25, 2026',
    condition: 'Stable',
    photoUrl: 'https://i.pravatar.cc/150?img=32',
    parentName: 'Ali Karim ',
    parentRelation: 'Père',
    parentPhone: '+213 555 789 012',
    parentEmail: 'karim.ali@email.com',
    medicalHistory: [
      'First Visit — New patient',
      'Growth Assessment — Normal range',
    ],
    allergies: ['Eggs'],
    bloodType: 'B-',
  ),
  PatientModel(
    id: 'P008',
    name: 'Limam kassem',
    age: '9 years old',
    gender: 'Male',
    weight: '32 kg',
    height: '140 cm',
    status: 'ACTIVE',
    lastVisit: 'Apr 18, 2026',
    condition: 'Managing',
    photoUrl: 'https://i.pravatar.cc/150?img=59',
    parentName: 'Limam Yasser',
    parentRelation: 'Père',
    parentPhone: '+213 555 890 123',
    parentEmail: 'Limam.Yasser@email.com',
    medicalHistory: [
      'ADHD — Under medication management',
      'Vision Check — Glasses prescribed 2025',
    ],
    allergies: ['Aspirin'],
    bloodType: 'A+',
  ),
  PatientModel(
    id: 'P009',
    name: 'Omar Benali',
    age: '7 years old',
    gender: 'Male',
    weight: '24 kg',
    height: '125 cm',
    status: 'ACTIVE',
    lastVisit: 'Apr 23, 2026',
    condition: 'Stable',
    photoUrl: 'https://i.pravatar.cc/150?img=14',
    parentName: 'Fatima Benali',
    parentRelation: 'Mère',
    parentPhone: '+213 555 901 234',
    parentEmail: 'fatima.benali@email.com',
    medicalHistory: [
      'Dental Caries — Treated Jan 2026',
      'Annual Checkup — Healthy development',
    ],
    allergies: [],
    bloodType: 'O+',
  ),
  PatientModel(
    id: 'P010',
    name: 'Miloudi Loubna',
    age: '5 years old',
    gender: 'Female',
    weight: '19 kg',
    height: '112 cm',
    status: 'ACTIVE',
    lastVisit: 'Apr 21, 2026',
    condition: 'Recovery',
    photoUrl: 'https://i.pravatar.cc/150?img=26',
    parentName: 'Jedid Soumia',
    parentRelation: 'Mère',
    parentPhone: '+213 555 012 345',
    parentEmail: 'Jedid.Soumia@email.com',
    medicalHistory: [
      'Pneumonia — Recovering, antibiotics course',
      'Vaccination — Flu vaccine Apr 2026',
    ],
    allergies: ['Amoxicillin'],
    bloodType: 'AB-',
  ),
];

// ── Helper: get patient by ID ─────────────────────────────────
PatientModel getPatientById(String id) {
  return allPatients.firstWhere(
    (p) => p.id == id,
    orElse: () => allPatients[0],
  );
}

// ── All Appointments (today = Apr 26, 2026) ───────────────────
const List<AppointmentModel> allAppointments = [
  // TODAY Apr 26
  AppointmentModel(id:'A001', patientId:'P006', type:'Routine Checkup', time:'08:30 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'completed'),
  AppointmentModel(id:'A002', patientId:'P005', type:'Immunization', time:'09:00 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'completed'),
  AppointmentModel(id:'A003', patientId:'P001', type:'Fever Follow-up', time:'09:30 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'completed'),
  AppointmentModel(id:'A004', patientId:'P003', type:'Vaccination', time:'10:00 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A005', patientId:'P004', type:'First Consultation', time:'10:30 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A006', patientId:'P002', type:'Recovery Check', time:'11:00 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A007', patientId:'P007', type:'Growth Assessment', time:'11:30 AM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A008', patientId:'P008', type:'ADHD Follow-up', time:'12:00 PM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A009', patientId:'P009', type:'Annual Checkup', time:'02:00 PM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A010', patientId:'P010', type:'Pneumonia Follow-up', time:'02:30 PM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A011', patientId:'P001', type:'Prescription Renewal', time:'03:00 PM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),
  AppointmentModel(id:'A012', patientId:'P005', type:'Ear Check', time:'03:30 PM', date:'Apr 26, 2026', dateKey:'2026-04-26', status:'waiting'),

  // TOMORROW Apr 27
  AppointmentModel(id:'A013', patientId:'P003', type:'Eczema Follow-up', time:'09:00 AM', date:'Apr 27, 2026', dateKey:'2026-04-27', status:'waiting'),
  AppointmentModel(id:'A014', patientId:'P002', type:'Physiotherapy Review', time:'10:00 AM', date:'Apr 27, 2026', dateKey:'2026-04-27', status:'waiting'),
  AppointmentModel(id:'A015', patientId:'P008', type:'Medication Check', time:'11:00 AM', date:'Apr 27, 2026', dateKey:'2026-04-27', status:'waiting'),

  // Apr 28
  AppointmentModel(id:'A016', patientId:'P009', type:'Dental Referral', time:'09:30 AM', date:'Apr 28, 2026', dateKey:'2026-04-28', status:'waiting'),
  AppointmentModel(id:'A017', patientId:'P010', type:'Chest X-Ray Review', time:'10:30 AM', date:'Apr 28, 2026', dateKey:'2026-04-28', status:'waiting'),

  // Apr 29
  AppointmentModel(id:'A018', patientId:'P007', type:'Vaccination', time:'09:00 AM', date:'Apr 29, 2026', dateKey:'2026-04-29', status:'waiting'),
  AppointmentModel(id:'A019', patientId:'P004', type:'Follow-up Fever', time:'11:00 AM', date:'Apr 29, 2026', dateKey:'2026-04-29', status:'waiting'),

  // Apr 30
  AppointmentModel(id:'A020', patientId:'P001', type:'Asthma Review', time:'10:00 AM', date:'Apr 30, 2026', dateKey:'2026-04-30', status:'waiting'),

  // May 1
  AppointmentModel(id:'A021', patientId:'P006', type:'7-month Checkup', time:'09:00 AM', date:'May 01, 2026', dateKey:'2026-05-01', status:'waiting'),
  AppointmentModel(id:'A022', patientId:'P003', type:'General Checkup', time:'10:30 AM', date:'May 01, 2026', dateKey:'2026-05-01', status:'waiting'),
];

// ── Helpers ──────────────────────────────────────────────────

// Retourne les rendez-vous d'aujourd'hui
List<AppointmentModel> getTodayAppointments() {
  return allAppointments
      .where((a) => a.dateKey == '2026-04-26')
      .toList();
}

// Retourne les rendez-vous pour une date spécifique
List<AppointmentModel> getAppointmentsByDate(String dateKey) {
  return allAppointments
      .where((a) => a.dateKey == dateKey)
      .toList();
}

// Compte le nombre total de patients
int getTotalPatientCount() {
  return allPatients.length;
}

// Compte seulement les rendez-vous en attente
int getUpcomingAppointmentCount() {
  return allAppointments.where((a) => a.status == 'waiting').length;
}