import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF6F7FB);
  static const Color surface = Colors.white;
  static const Color primary = Color(0xFF6C63FF);
  static const Color textPrimary = Color(0xFF1F2430);
  static const Color textSecondary = Color(0xFF6F7480);
  static const Color border = Color(0xFFE4E7EF);
}

class AppTextStyles {
  static const TextStyle screenTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
