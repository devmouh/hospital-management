// ============================================================
// ALL 4 DOCTOR PAGES - Copy each class to its own file
// ============================================================
// Files needed:
//   doctor_home.dart
//   doctor_schedule.dart
//   doctor_patients.dart
//   doctor_profile.dart
// ============================================================

import 'package:flutter/material.dart';

const Color kTeal    = Color(0xFF4DB6AC);
const Color kBg      = Color(0xFFF5F5F5);
const Color kWhite   = Color(0xFFFFFFFF);
const Color kGrey    = Color(0xFF9E9E9E);

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
                  ? Color(0x40FFFFFF)
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

// ============================================================
// PAGE 1 — DOCTOR HOME (Dashboard)
// ============================================================

const List<Map<String, String>> _upcomingAppointments = [
  {'name': 'Leo Harrison',   'type': 'Routine Checkup • 6 months',  'time': '09:30 AM'},
  {'name': 'Sophia Miller',  'type': 'Immunization • 4 years',       'time': '10:15 AM'},
  {'name': 'Noah Garcia',    'type': 'Fever Follow-up • 2 years',    'time': '11:00 AM'},
  {'name': 'Ahmed Aaaaa',    'type': 'Growth Assessment • 12 months','time': '11:45 AM'},
];

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
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

                    // ── Header ─────────────────────────────
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=12'),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. James Wilson',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Text('Pediatrician • St. Mary\'s Hospital',
                                  style: TextStyle(
                                      color: kGrey, fontSize: 11)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Stats row ───────────────────────────
                    Row(
                      children: [
                        _statCard('12', "Today's\nAppointments",
                            Icons.calendar_today, kTeal),
                        const SizedBox(width: 12),
                        _statCard('462', 'Total\nPatients',
                            Icons.people_outline, Color(0xFF448AFF)),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── Urgent cases ────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Color(0xFFEF9A9A)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.priority_high,
                                color: kWhite, size: 16),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Urgent Cases',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              Text('2 patients need immediate attention',
                                  style:
                                      TextStyle(color: kGrey, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Text('2',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Upcoming appointments ───────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Upcoming Appointments',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View All',
                              style: TextStyle(color: kTeal)),
                        ),
                      ],
                    ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _upcomingAppointments.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                      itemBuilder: (_, i) =>
                          _appointmentTile(_upcomingAppointments[i]),
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

  Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x1F000000), blurRadius: 6)
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: color)),
                Text(label,
                    style:
                        const TextStyle(color: kGrey, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appointmentTile(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage('https://i.pravatar.cc/150?img=5'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(data['type']!,
                    style:
                        const TextStyle(color: kGrey, fontSize: 11)),
              ],
            ),
          ),
          Text(data['time']!,
              style: const TextStyle(
                  color: kTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

// ============================================================
// PAGE 2 — DOCTOR SCHEDULE
// ============================================================
class DoctorSchedule extends StatefulWidget {
  const DoctorSchedule({super.key});

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  int _selectedDay   = 2; // index in week
  int _selectedTab   = 0; // 0=All 1=Waiting 2=Completed

  final List<String> _days  = ['16', '17', '18', '19', '20', '21'];
  final List<String> _dnames= ['MON','TUE','WED','THU','FRI','SAT'];

  final List<Map<String, String>> _appointments = const [
    {'name':'Leo Thompson',  'age':'7 years','type':'General Checkup',
     'time':'10:30 AM','status':'waiting'},
    {'name':'Maya Garcia',   'age':'5 years','type':'Vaccination',
     'time':'11:15 AM','status':'waiting'},
    {'name':'Noah Wilson',   'age':'3 years','type':'Follow-up',
     'time':'09:00 AM','status':'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedTab == 0
        ? _appointments
        : _selectedTab == 1
            ? _appointments.where((a) => a['status'] == 'waiting').toList()
            : _appointments
                .where((a) => a['status'] == 'completed')
                .toList();

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
                      Icon(Icons.calendar_month, size: 26),
                      SizedBox(width: 8),
                      Text('schedule',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ]),

                    const SizedBox(height: 4),
                    const Text('October 2023',
                        style: TextStyle(color: kGrey, fontSize: 13)),

                    const SizedBox(height: 14),

                    // Week strip
                    SizedBox(
                      height: 68,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _days.length,
                        itemBuilder: (_, i) {
                          final sel = i == _selectedDay;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedDay = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 52,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(_dnames[i],
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: sel
                                              ? kWhite
                                              : kGrey)),
                                  const SizedBox(height: 4),
                                  Text(_days[i],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              sel ? kWhite : Color(0xFF000000))),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Tabs
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
                              onTap: () => setState(
                                  () => _selectedTab = e.key),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                decoration: BoxDecoration(
                                  color: sel
                                      ? kTeal
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                                child: Text(e.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            sel ? kWhite : kGrey,
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

                    // Appointment list
                    Expanded(
                      child: ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (_, i) =>
                            _scheduleCard(context, filtered[i]),
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

  Widget _scheduleCard(
      BuildContext context, Map<String, String> data) {
    final done = data['status'] == 'completed';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=8'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['name']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text(
                        '${data['age']} • ${data['type']}',
                        style: const TextStyle(
                            color: kGrey, fontSize: 12)),
                    Text(data['time']!,
                        style: const TextStyle(
                            color: kGrey, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: done
                      ? Color(0xFFE8F5E9)
                      : Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  done ? 'Completed' : 'Waiting',
                  style: TextStyle(
                      color: done ? Colors.green : Colors.orange,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTeal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                      done ? 'View Summary' : 'Start Consultation',
                      style: const TextStyle(
                          color: kWhite, fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PAGE 3 — PATIENT RECORDS
// ============================================================
class DoctorPatients extends StatefulWidget {
  const DoctorPatients({super.key});

  @override
  State<DoctorPatients> createState() => _DoctorPatientsState();
}

class _DoctorPatientsState extends State<DoctorPatients> {
  int _selectedFilter = 0; // 0=All 1=Active 2=New
  String _search = '';

  final List<Map<String, String>> _patients = const [
    {'name': 'Liam Henderson', 'age': '6 years old', 'status': 'ACTIVE',
     'lastVisit': 'Oct 12, 2023', 'condition': 'Stable'},
    {'name': 'Mia Thompson',   'age': '4 years old', 'status': 'ACTIVE',
     'lastVisit': 'Nov 02, 2023', 'condition': 'Recovery'},
    {'name': 'Ethan Clarke',   'age': '8 years old', 'status': 'ACTIVE',
     'lastVisit': 'Sep 15, 2023', 'condition': 'Managing'},
    {'name': 'Sara Ali',       'age': '2 years old', 'status': 'NEW',
     'lastVisit': 'Nov 10, 2023', 'condition': 'Stable'},
    {'name': 'Omar Benali',    'age': '5 years old', 'status': 'NEW',
     'lastVisit': 'Nov 08, 2023', 'condition': 'Stable'},
  ];

  @override
  Widget build(BuildContext context) {
    final filters = ['All Patients', 'Active', 'New'];

    List<Map<String, String>> filtered = _patients.where((p) {
      final matchSearch = p['name']!
          .toLowerCase()
          .contains(_search.toLowerCase());
      final matchFilter = _selectedFilter == 0
          ? true
          : _selectedFilter == 1
              ? p['status'] == 'ACTIVE'
              : p['status'] == 'NEW';
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

                    // Title
                    const Text('Patient Records',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),

                    const SizedBox(height: 14),

                    // Search
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

                    // Filter chips
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
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    sel ? kTeal : kWhite,
                                borderRadius:
                                    BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x1F000000),
                                      blurRadius: 3)
                                ],
                              ),
                              child: Text(e.value,
                                  style: TextStyle(
                                      color: sel
                                          ? kWhite
                                          : Colors.black,
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

                    // Patient list
                    Expanded(
                      child: ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (_, i) =>
                            _patientCard(filtered[i]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildDoctorBottomNav(context, 2),
          ],
        ),
      ),
    );
  }

  Widget _patientCard(Map<String, String> p) {
    final isNew = p['status'] == 'NEW';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 5)
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage:
                NetworkImage('https://i.pravatar.cc/150?img=3'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isNew
                            ? Color(0xFFE3F2FD)
                            : Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['status']!,
                          style: TextStyle(
                              color: isNew
                                  ? Colors.blue
                                  : Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 6),
                    Text(p['age']!,
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
                            fontWeight: FontWeight.bold)),
                    const Text('STATUS  ',
                        style: TextStyle(
                            color: kGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text(p['lastVisit']!,
                        style: const TextStyle(fontSize: 11)),
                    const SizedBox(width: 16),
                    Text(p['condition']!,
                        style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: kGrey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PAGE 4 — DOCTOR PROFILE
// ============================================================
class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
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

                    // Title
                    const Text('My Account',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),

                    const SizedBox(height: 20),

                    // Profile card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kTeal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=12'),
                          ),
                          const SizedBox(height: 12),
                          const Text('Dr. Saif Ababon',
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const Text('Ophthalmologist',
                              style: TextStyle(
                                  color: Color(0xB3FFFFFF),
                                  fontSize: 13)),
                          const SizedBox(height: 16),

                          // Stats
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              _profileStat('2', 'Children'),
                              _profileStat('5', 'Appointments'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Professional details
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Professional Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit Profile',
                              style: TextStyle(color: kTeal)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    _detailItem(Icons.email_outlined,
                        'sarah.parent@email.com'),
                    _detailItem(
                        Icons.phone_outlined, '+1 (555) 123-4567'),
                    _detailItem(
                        Icons.location_on_outlined, 'New York, USA'),

                    const SizedBox(height: 24),

                    // Working hours
                    const Text('Working Hours',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),

                    const SizedBox(height: 10),

                    _hoursCard('Mon — Fri', '08:00 AM - 05:00 PM',
                        false),
                    _hoursCard(
                        'Saturday', '09:00 AM - 01:00 PM', false),
                    _hoursCard('Sunday', 'Closed', true),

                    const SizedBox(height: 24),

                    // Settings
                    const Text('Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    _settingItem(
                        Icons.notifications_none, 'Notifications', false),
                    _settingItem(
                        Icons.lock_outline, 'Privacy & Security', false),
                    _settingItem(
                        Icons.help_outline, 'Help & Support', false),
                    _settingItem(
                        Icons.logout, 'Logout', true),
                  ],
                ),
              ),
            ),
            buildDoctorBottomNav(context, 3),
          ],
        ),
      ),
    );
  }

  Widget _profileStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: kWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(
                color: Color(0xB3FFFFFF), fontSize: 12)),
      ],
    );
  }

  Widget _detailItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: kTeal, size: 20),
          const SizedBox(width: 14),
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _hoursCard(String day, String hours, bool closed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 4)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          Text(hours,
              style: TextStyle(
                  color: closed ? Colors.red : kTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ],
      ),
    );
  }

  Widget _settingItem(
      IconData icon, String label, bool isDanger) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          Icon(icon,
              color: isDanger ? Colors.red : kTeal, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color:
                        isDanger ? Colors.red : Color(0xFF000000))),
          ),
          if (!isDanger)
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: kGrey),
        ],
      ),
    );
  }
}
