import 'package:flutter/material.dart';

/// Paleta de la app: un azul petróleo sobrio y un acento ámbar para lo "de hoy".
class AppColors {
  static const background = Color(0xFFF2F5F7);
  static const ink = Color(0xFF10262E);
  static const muted = Color(0xFF5E7480);
  static const line = Color(0xFFE3EAEE);
  static const primary = Color(0xFF0E5A6B);

  static const cases = Color(0xFF2F7FD1);
  static const todayCases = Color(0xFFE8A33D);
  static const deaths = Color(0xFFC8443F);
  static const todayDeaths = Color(0xFFE57373);
  static const recovered = Color(0xFF2E9E6B);

  static const dangerSoft = Color(0xFFFBE4E3);
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}