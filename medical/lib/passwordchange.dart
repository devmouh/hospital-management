import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PasswordSuccessScreen(),
  ));
}
class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

          Center(
            child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F2F1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user,
              size: 100,
              color: Color(0xFF00897B),
            ),
          ),
        ),
        const SizedBox(height: 40),

      const Text("Password Changed\nSuccessfully!",
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    const SizedBox(height: 20),

    Text(
    "Your password has been updated\nsuccessfully. You can now log in to your\naccount.",
    textAlign: TextAlign.center,
    style: TextStyle(
    fontSize: 14,
    color: Colors.grey.shade600,
    height: 1.5,
    ),
    ),
    const SizedBox(height: 50),

    ElevatedButton(
    onPressed: () {
    Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF00897B),
    minimumSize: const Size(double.infinity, 55),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    elevation: 5,
    ),
    child: const Text(
    "Login Now",
    style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    ),
    const SizedBox(height: 20),

    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Text(
    "Back to Home? ",
    style: TextStyle(color: Colors.grey),
    ),
    GestureDetector(
    onTap: () {
    Navigator.pop(context);
    },
    child: const Text(
    "Login",
    style: TextStyle(
    color: Color(0xFF00897B),
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 30),
    // Pagination dots
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(
    color: Colors.grey.shade300,
    shape: BoxShape.circle,
    ),
    ),
    const SizedBox(width: 8),
    Container(
    width: 20,
    height: 8,
    decoration: BoxDecoration(
    color: const Color(0xFF00897B),
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
    );
  }
}

