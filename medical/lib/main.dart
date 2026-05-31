import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:medical/login.dart';
import 'package:medical/providers/doctor_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DoctorProvider())],
      child: MaterialApp(
        routes: {
          '/': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    ),
  );
}
