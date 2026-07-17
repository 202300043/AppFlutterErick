import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B0B0D);
  static const Color surface = Color(0xFF1C1C1F);
  static const Color accent = Color(0xFF0A84FF);
  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFF9A9A9E);
  static const Color success = Color(0xFF32D74B);
  static const Color danger = Color(0xFFFF453A);
}

final CupertinoThemeData appCupertinoTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.accent,
  scaffoldBackgroundColor: AppColors.background,
  barBackgroundColor: AppColors.surface,
  textTheme: CupertinoTextThemeData(
    primaryColor: AppColors.accent,
    textStyle: const TextStyle(
      inherit: false,
      color: AppColors.textPrimary,
      fontSize: 16,
    ),
    navTitleTextStyle: const TextStyle(
      inherit: false,
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    navLargeTitleTextStyle: const TextStyle(
      inherit: false,
      color: AppColors.textPrimary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    navActionTextStyle: const TextStyle(
      inherit: false,
      color: AppColors.accent,
      fontSize: 16,
    ),
  ),
);
