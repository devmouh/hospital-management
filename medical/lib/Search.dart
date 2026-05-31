import 'package:flutter/material.dart';
class FindDoctorPage extends StatelessWidget {
  const FindDoctorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F7F6),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Row(
            children: [
                IconButton(
                onPressed: () {
          Navigator.pop(context);
          },
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Find Doctor",
                style:
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
          ],
        ),
        const SizedBox(height: 20),

        Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
    BoxShadow(color: Colors.black12, blurRadius: 5),
    ],
    ),
    child: const TextField(
    decoration: InputDecoration(
    icon: Icon(Icons.search),
    hintText: "Dr. Ghiles Amina",
    border: InputBorder.none,
    ),
    ),
    ),
    const SizedBox(height: 20),

        const Text(
    "Search Results",
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 15),
    _doctorCard(),
    ],
    ),
    ),
    ),
    );
  }

  Widget _doctorCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Row(
        children: [

        Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.teal.withValues(alpha: 0.1),
        ),
        child: const Icon(Icons.person, size: 40, color: Colors.teal),
      ),
      const SizedBox(width: 15),

    Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
      Text(
      "Dr. Ghiles Amina",
      style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    ),
    SizedBox(height: 5),
    Text(
    "Orthopedic | Apollo Clinics",
    style: TextStyle(
    color: Colors.grey,
    fontSize: 12,
    ),
    ),
    ],
    ),
    ),

    Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: const [
    Icon(Icons.favorite_border, color: Colors.grey),
    SizedBox(height: 10),
    Text(
    "2500Da/visit",
    style: TextStyle(
    color: Colors.teal,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    ),
    ),
    ],
    ),
    ],
    ),
    );
  }
}






