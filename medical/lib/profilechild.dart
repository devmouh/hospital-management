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
      home: ChildProfileScreen(),
    );
  }
}
class ChildProfileScreen extends StatelessWidget {
  const ChildProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.person, color: Colors.black, size: 30),
        title: const Text(
          "Child Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainInfoCard(),
            const SizedBox(height: 20),
            const Text("Medical Info",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _buildMedicalCard(),
            const SizedBox(height: 20),
            const Text("Recent Activity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _buildRecentActivityCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }
  Widget _buildMainInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage:
            NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(height: 10),
          const Text("Ahmed",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text("Male", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoTile("AGE", "6 years old", Icons.cake),
              _infoTile("WEIGHT", "22 kg", Icons.scale),
              _infoTile("HEIGHT", "120 cm", Icons.straighten),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.sync, color: Color(0xFF4DB6AC)),
            label: const Text("Switch Child",
                style: TextStyle(color: Color(0xFF4DB6AC))),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE0F2F1),
              shape: const StadiumBorder(),
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }
  Widget _infoTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4DB6AC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 10)),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildMedicalCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: const [
          _CustomListTile("Milk", "", Icons.breakfast_dining),
          Divider(height: 1),
          _CustomListTile("O+", "BLOOD TYPE", Icons.water_drop),
          Divider(height: 1),
          _CustomListTile("None", "CHRONIC DISEASES", Icons.warning_amber_rounded),
        ],
      ),
    );
  }
  Widget _buildRecentActivityCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: const [
          _CustomListTile("OCT 11, 2025", "RECENT VISIT", Icons.calendar_today),
          Divider(height: 1),
          _CustomListTile("OCT 12, 2025", "LAST VACCINATION", Icons.calendar_month),
        ],
      ),
    );
  }
  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4DB6AC),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: const Icon(Icons.home_outlined, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {}),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: const [
                Icon(Icons.person_outline, color: Color(0xFF4DB6AC)),
                SizedBox(width: 5),
                Text("PROFILE",
                    style: TextStyle(
                        color: Color(0xFF4DB6AC),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class _CustomListTile extends StatelessWidget {
  final

  String title;
  final

  String subtitle;
  final

  IconData icon;

  const _CustomListTile(this.title, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white),

      ),
      title: subtitle.isEmpty
          ?
      Text(title):
      Text(subtitle,
          style: const TextStyle(fontSize: 10, color: Colors.grey)),
      subtitle: subtitle.isEmpty
          ? null
          :
      Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}