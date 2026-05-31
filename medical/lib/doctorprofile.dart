import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorBookingScreen(),
    );
  }
}

class DoctorBookingScreen extends StatelessWidget {
  const DoctorBookingScreen({super.key});
  final Color primaryGreen = const Color(0xFF00A99D);
  final Color lightBg = const Color(0xFFE8F6F4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Image.network(
                      'https://via.placeholder.com/400x500',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Positioned(
                  top: 55,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Doctor",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Ophthalmologist",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "Dr. Saif Ababon",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _InfoBadge(icon: Icons.calendar_month, text: "Sun-Thu"),
                      _InfoBadge(icon: Icons.access_time, text: "9:00-15:00"),
                      _InfoBadge(icon: null, text: "2500Da/visit"),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "April 2025",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.chevron_left, color: Colors.grey),
                          Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const CalendarStrip(),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: lightBg,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today Availability",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            TimeSlot("9:00-10:00"),
                            TimeSlot("10:00-11:00", isAvailable: false),
                            TimeSlot("11:00-12:00", isSelected: true),
                            TimeSlot("12:00-13:00"),
                            TimeSlot("13:00-14:00"),
                            TimeSlot("14:00-15:00", isAvailable: false),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Book Appointment",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData? icon;
  final String text;
  const _InfoBadge({this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A99D);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white, size: 16),
          if (icon != null) const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class CalendarStrip extends StatelessWidget {
  const CalendarStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DayCard("Sat", "29"),
          DayCard("Sun", "30"),
          DayCard("Mon", "31"),
          DayCard("Tue", "01"),
          DayCard("Wed", "02"),
          DayCard("Thu", "03"),
          DayCard("Fri", "04"),
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  const DayCard(this.day, this.date, {this.isSelected = false, super.key});
  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A99D);
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? primaryGreen : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: primaryGreen.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),

      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey),
          ),
          const SizedBox(height: 5),
          CircleAvatar(
            radius: 15,
            backgroundColor: isSelected ? Colors.white : Colors.transparent,
            child: Text(
              date,
              style: TextStyle(
                color: isSelected ? primaryGreen : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isAvailable;
  const TimeSlot(
    this.time, {
    this.isSelected = false,
    this.isAvailable = true,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A99D);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? primaryGreen
            : (isAvailable ? Colors.white : Colors.grey),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5),
        ],
      ),
      child: Text(
        time,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : (isAvailable ? Colors.black : Colors.grey),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
