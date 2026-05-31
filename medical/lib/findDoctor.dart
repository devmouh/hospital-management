import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FindDoctorScreen(),
  ));
}
class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});
  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}
class _FindDoctorScreenState extends State<FindDoctorScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8FBFB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          title: const Text(
            "Find Doctor",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
            children: [
            const SizedBox(height: 10),


        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
    children: [
    _buildCategory("All", 0),
    _buildCategory("General", 1),
    _buildCategory("Eye care", 2),
    _buildCategory("Pulmonary", 3),
    ],
    ),
    ),
    const SizedBox(height: 10),

    Expanded(
    child: ListView(
    padding: const EdgeInsets.all(16),
    children: [
    _buildDoctorCard("Dr. Kaniz Fatema Noor", "Ophthalmologist", "10", true),
    _buildDoctorCard("Dr. Michael Chen", "General Practitioner", "10", true),
    _buildDoctorCard("Dr. Sarah Jahan", "Pulmonologist", "5", false),
    _buildDoctorCard("Dr. Zahid Hasan", "Allergist", "4", false),
    _buildDoctorCard("Dr. James Robinson", "Pediatrician", "8", false),
    ],
    ),
    ),
    ],
    ),
    );
    }

  Widget _buildCategory(String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4DB6AC) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialist, String exp, bool isFavorite) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


        ClipRRect(
        borderRadius: BorderRadius.circular(15),
    child: Container(
    width: 90,
    height: 90,
    color: Colors.grey[200],
    child: const Icon(Icons.person, size: 50, color: Colors.grey),
    ),
    ),
    const SizedBox(width: 15),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child: Text(
    name,
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    overflow: TextOverflow.ellipsis,
    ),
    ),
    Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
    color: isFavorite ? Colors.redAccent : Colors.grey,
    ),
    ],
    ),
    const SizedBox(height: 5),
    Text(
    "$specialist | $exp Years Exp",
    style: const TextStyle(color: Colors.grey, fontSize: 13),
    ),
    const SizedBox(height: 10),
    Row(
    children: const [
    Icon(Icons.star, color: Colors.orange, size: 16),
    SizedBox(width: 4),
    Text("4.8"),
    ],
    ),
    const SizedBox(height: 10),
    Align(
    alignment: Alignment.bottomRight,
    child: Text(
    "2500 DA / visit",
    style: TextStyle(
    color: Colors.teal[700],
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
}
