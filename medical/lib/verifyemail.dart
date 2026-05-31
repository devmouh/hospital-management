import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical/reset_password.dart';
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}
class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final

  List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final

  List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter  code ")),
      );
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Verify Email", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 40),
            _buildIllustration(),
            SizedBox(height: 40),
            _buildText(),
            SizedBox(height: 40),
            _buildOtp(),
            SizedBox(height: 40),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      height: 200,
      child: Image.asset(
        'assets/file_000000000d9871f5a5e693d1f52596d2.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildText() {
    return Column(
      children: [
        Text("Enter Code",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(" donner un code ",

        textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 60,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 1,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 3) {
                  _focusNodes[index + 1].requestFocus();
                }
              } else {
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          onPressed: _verifyCode,
          child: Text("Verify"),
    ),);
  }
}