import 'package:flutter/material.dart';
class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({super.key});
  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}
class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  bool _isObscure = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8FBFB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Edit phone number",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),


    body: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 30),


    const Text("Password",
    style: TextStyle(fontWeight: FontWeight.w500)),
    const SizedBox(height: 8),
    TextField(
    controller: passwordController,
    obscureText: _isObscure,
    decoration: InputDecoration(
    hintText: "Enter your password",
    hintStyle:
    TextStyle(color: Colors.grey[400], fontSize: 14),
    filled: true,
    fillColor: Colors.white,
    suffixIcon: IconButton(
    icon: Icon(_isObscure
    ? Icons.visibility_outlined
        : Icons.visibility_off_outlined),
    onPressed: () {
    setState(() {
    _isObscure = !_isObscure;
    });
    },
    color: Colors.grey,
    ),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    ),
    const SizedBox(height: 20),

// Phone
    const Text("New phone number",
    style: TextStyle(fontWeight: FontWeight.w500)),
    const SizedBox(height: 8),
    TextField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
    hintText: "Enter new phone number",
    hintStyle:
    TextStyle(color: Colors.grey[400], fontSize: 14),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    ),
    const SizedBox(height: 40),

// Button
    SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
    onPressed: () {
    String password = passwordController.text;
    String phone = phoneController.text;
    print(password);
    print(phone);

    },
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFD1F0E4),
    foregroundColor: const Color(0xFF1A7369),
    elevation: 0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
    ),
    ),
    child: const Text(
    "Save change",
    style: TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold),
    ),
    ),
    ),
    ],
    ),
    ),
    );
  }
}
