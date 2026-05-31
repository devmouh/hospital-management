import 'package:flutter/material.dart';
import 'package:medical/passwordchange.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isNewPassVisible = false;
  bool _isConfirmPassVisible = false;
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordSuccessScreen()));
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
        title: const Text("My Child health", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/IMG_20260413_231112_281.jpg',
                height: 180,
              ),
              const SizedBox(height: 30),
              const Text(
                "Reset Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter your new password to access your account",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildConfirmField(),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _updatePassword,
                  child: const Text(
                    "Update Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: !_isNewPassVisible,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Min 6 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter new password",
        suffixIcon: IconButton(
          icon: Icon(_isNewPassVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isNewPassVisible = !_isNewPassVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildConfirmField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPassVisible,
      validator: (value) {
        if (value != _newPasswordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Confirm new password",
        suffixIcon: IconButton(
          icon: Icon(_isConfirmPassVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isConfirmPassVisible = !_isConfirmPassVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}



