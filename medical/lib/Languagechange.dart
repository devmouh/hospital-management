import 'package:flutter/material.dart';
class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({super.key});
  @override
  State<LanguageSettingScreen> createState() => _LanguageSettingScreenState();
}
class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  String selectedLanguage = 'English';
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
          "Language setting",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildLanguageOption("English"),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _buildLanguageOption("اﻟﻌﺮﺑﻴﺔ"),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _buildLanguageOption("Français"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print("Selected: $selectedLanguage");
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLanguageOption(String title) {
    bool isSelected = selectedLanguage == title;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4DB6AC) : Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : const Icon(Icons.circle, color: Colors.transparent, size: 16),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        setState(() {
          selectedLanguage = title;
        });
      },
    );
  }
}






