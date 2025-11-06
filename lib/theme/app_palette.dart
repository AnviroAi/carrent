import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const primary = Color(0xFF353568);
  static const gradientStart = Color(0xFF29294C);
  static const gradientEnd = Color(0xFF181821);
  static const surface = Colors.white;
  static const mutedText = Color(0xFF6F6F8C);
  static const hint = Color(0xFF9BA0B8);
  static const divider = Color(0xFFE4E5F0);
  static const softSurface = Color(0xFFF3F3F9);
  static const pageBackground = Color(0xFFF5F5FD);
  static const tabHeaderStart = Color(0xFFE4E3F7);
  static const tabHeaderEnd = Color(0xFFC8C6EB);
  static const accentSuccess = Color(0xFF07C168);
  static const accentWarning = Color(0xFFE8772F);
  static const accentDanger = Color(0xFFD1435B);
  static const accentSuccessPill = Color(0xFF1FAA59);
  static const pillBackground = Color(0xFFF8F8FF);
  static const garageBackground = Color(0xFFE8F8EE);
  static const warningBackground = Color(0xFFFFF2E2);
  static const dangerBackground = Color(0xFFFFE6E9);
}

class AppGradients {
  const AppGradients._();

  static const primary = LinearGradient(
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const tabsHeader = LinearGradient(
    colors: [AppColors.tabHeaderStart, AppColors.tabHeaderEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
