import 'package:cricstatz/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final TextTheme textTheme = GoogleFonts.lexendTextTheme();

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppPalette.accent,
        brightness: Brightness.dark,
        surface: AppPalette.bgPrimary,
      ),
      scaffoldBackgroundColor: AppPalette.bgPrimary,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppPalette.textPrimary,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppPalette.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      useMaterial3: true,
    );
  }

  const AppTheme._();
}
