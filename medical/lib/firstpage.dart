import 'package:flutter/material.dart';
import 'package:medical/Search.dart';
import 'package:medical/login.dart';
import 'package:medical/notification.dart';
import 'package:medical/profile.dart';
import 'package:medical/schedule.dart';
import 'package:medical/findDoctor.dart';
import 'package:medical/profilechild.dart';
import 'package:medical/doctorprofile.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MedicalAppHome(),
  ));
}

class MedicalAppHome extends StatelessWidget {
  const MedicalAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome, Sarah",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Monday, 23 October",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFFEEEEEE),
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindDoctorPage()),
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF4DB6AC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ACTIVE PATIENT",
                                style: TextStyle(color: Colors.white70, fontSize: 10)),
                            const Text("Liam Johnson",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const Text("6 years old • Male",
                                style: TextStyle(color: Colors.white70, fontSize: 12)),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChildProfileScreen()));
                            }, icon: const Icon(Icons.arrow_forward))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _infoSmallBox(Icons.height, "120cm")),
                        const SizedBox(width: 10),
                        Expanded(child: _infoSmallBox(Icons.monitor_weight_outlined, "22kg")),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(

                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder:(context)  =>  myPopupDesign(context),
                          );
                        },


                      icon: const Icon(Icons.sync, color: Color(0xFF4DB6AC)),
                      label: const Text("Switch Child",
                          style: TextStyle(color: Color(0xFF4DB6AC))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text("Our services",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _serviceItem(Icons.face, "General\nPediatrics")),
                  const SizedBox(width: 10),
                  Expanded(child: _serviceItem(Icons.remove_red_eye, "Eye Care")),
                  const SizedBox(width: 10),
                  Expanded(child: _serviceItem(Icons.air, "Pneumology")),
                ],
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Top Doctors",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  FindDoctorScreen()));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color(0xFF4DB6AC),
                      foregroundColor: Colors.white,
                      padding:  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20),
                      ),
                      elevation: 2,
                    ),
                    child:  const Text(
                      "View More",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                    ],
              ),

              const SizedBox(height: 15),
              _doctorCard(name: "Dr. Kaniz Fatema Noor",specialty:  "Ophthalmologist",price:  "2500Da/visit",onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorBookingScreen()));}
              ),
              _doctorCard(name: "Dr. Michael Chen",specialty:  "General Practitioner",price:  "2500Da/visit" ,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorBookingScreen()));}),

            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _infoSmallBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _serviceItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black12)],
          ),
          child: Icon(icon, color: const Color(0xFF4DB6AC), size: 25),
        ),
        const SizedBox(height: 8),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF4DB6AC),
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _doctorCard({ required String name,  required String specialty, required String price, required VoidCallback onTap,}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF4DB6AC).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.person, size: 40, color: Color(0xFF4DB6AC)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$specialty | 10 Years Exp",
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(price,
                      style: const TextStyle(
                          color: Color(0xFF4DB6AC),
                          fontWeight: FontWeight.bold)),
                ),
              const  Icon(Icons.arrow_forward),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: Colors.red, size: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4DB6AC),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'HOME', true, () {}),
          _buildNavItem(Icons.calendar_month, 'SCHEDULE', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Schedule()),
            );
          }),
          // ✅ Fixed: was malformed before
          _buildNavItem(Icons.notifications_none, 'NOTIFICATION', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          }),
          // ✅ Fixed: was malformed before
          _buildNavItem(Icons.person_outline, 'PROFILE', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  Widget myPopupDesign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          const Text(
            "Switch child",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1A7369),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      const Divider(),
      ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: const Text("Ahmed"),
        subtitle: const Text("5 Years | Male"),
        trailing: const Icon(Icons.check_circle, color: Color(0xFF1A7369)),
      ),
      ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: const Text("Sara"),
        subtitle: const Text("7 Years | Female"),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
      ),
      ],
    ),
    );
  }

}