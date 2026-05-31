// lib/login.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical/forgetpassword.dart';
import 'package:medical/firstpage.dart';
import 'package:medical/doctor_pages/doctor_home.dart';
import 'package:medical/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http
            .post(
              Uri.parse('${ApiService.baseUrl}/api/users/auth/login/'),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: jsonEncode({
                'username': _emailController.text.trim(),
                'email': _emailController.text
                    .trim(), // Sent as fallback just in case backend requires 'email'
                'password': _passwordController.text,
              }),
            )
            .timeout(const Duration(seconds: 10));

        // 👇 These print directly to your terminal so you can see the real backend response!
        debugPrint('Login Response Status: ${response.statusCode}');
        debugPrint('Login Response Body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body);

          // 1. SAFELY extract token no matter how Django formats it
          String? token;
          if (data.containsKey('access')) {
            token = data['access'];
          } else if (data.containsKey('token')) {
            token = data['token'];
          } else if (data.containsKey('tokens') && data['tokens'] != null) {
            token = data['tokens']['access'];
          }

          ApiService.accessToken = token ?? '';

          // 2. SAFELY extract user role
          String role = '';
          if (data.containsKey('role')) {
            role = data['role'];
          } else if (data.containsKey('user') && data['user'] != null) {
            role = data['user']['role'] ?? '';
          }

          // Normalize string to avoid case-sensitive mismatches
          role = role.toUpperCase();

          if (!mounted) return;

          if (role == 'DOCTOR' || role == 'MEDECIN') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DoctorHome()),
            );
          } else {
            // Default to Parent / Client home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MedicalAppHome()),
            );
          }
        } else {
          // Properly catch 400 or 401 errors
          final data = jsonDecode(response.body);
          final String errorMsg =
              data['detail'] ??
              data['non_field_errors']?[0] ??
              'Identifiants incorrects.';

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        debugPrint('Login Exception Caught: $e'); // See the exact crash reason

        if (!mounted) return;
        // Safe Offline Developer Fallback: allows testing the UI offline
        if (_passwordController.text == "doctor") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Serveur hors ligne. Connexion hors ligne Médecin.',
              ),
              backgroundColor: Colors.orange,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorHome()),
          );
        } else if (_passwordController.text == "parent") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Serveur hors ligne. Connexion hors ligne Parent.'),
              backgroundColor: Colors.orange,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MedicalAppHome()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur réseau ou système: $e'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 30),
                      _buildEmailField(),
                      const SizedBox(height: 20),
                      _buildPasswordField(),
                      _buildForgotPassword(),
                      const SizedBox(height: 30),
                      _buildLoginButton(),
                      const SizedBox(height: 20),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: Image.asset(
            'assets/IMG_20260413_231120_468.jpg',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Log In",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF009688),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nom d'utilisateur / Email",
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Nom d'utilisateur requis";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "medecin1 ou email@example.com",
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password", style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          validator: (value) {
            if (value == null || value.length < 4) {
              return "Min 4 characters";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "••••••••",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ), // Assuming const constructor exists
          );
        },
        child: const Text("Forgot password?"),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF009688),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                "Log In",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "If you don't have an account",
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        Text(
          "contact our helpline",
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ],
    );
  }
}
