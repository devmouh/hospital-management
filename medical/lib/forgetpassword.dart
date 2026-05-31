import 'package:flutter/material.dart';
import 'package:medical/verifyemail.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyEmailScreen ()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildIllustration(),
                const SizedBox(height: 40),
                _buildTextSection(),
                const SizedBox(height: 30),
                _buildEmailField(),
                const SizedBox(height: 50),
                _buildSendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      height: 200,
      child: Image.asset(
        'assets/IMG_20260413_231115_881.jpg',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTextSection() {
    return Column(
      children: [
        const Text(
          "Enter your Email",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text("Enter your email to receive a\npassword reset link")
      ],
    );
  }
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      "Email Address",
      style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
    ),
    const SizedBox(height: 10),
    TextFormField(
    controller: _emailController,
    keyboardType: TextInputType.emailAddress,


    validator: (value) {
    if (value == null || value.isEmpty) {
    return "Email required";
    }
    if (!value.contains("@")) {
    return "Invalid email";
    }
    return null;
    },
    decoration: InputDecoration(
    hintText: "example@email.com",
    prefixIcon: const Icon(Icons.email_outlined),
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
    ),
    contentPadding:
    const EdgeInsets.symmetric(vertical: 18),
    ),
    ),
    ],
    );
  }
  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00897B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _sendResetLink,
        child: const Text(
      "Send Reset Link",
      style: TextStyle(
      fontSize: 18,
      color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    ),
    );
  }
}






