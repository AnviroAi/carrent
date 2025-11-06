import 'package:flutter/material.dart';

import 'screens/login/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CarRentApp());
}

class CarRentApp extends StatelessWidget {
  const CarRentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const LoginScreen(),
    );
  }
}
