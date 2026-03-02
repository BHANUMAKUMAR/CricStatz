import 'package:flutter/material.dart';

class AppPalette {
  static const Color bgPrimary = Color(0xFF111721);
  static const Color bgSecondary = Color(0xFF0A1F43);
  static const Color cardPrimary = Color(0xFF0D1E3F);
  static const Color cardOverlay = Color(0x661E293B);
  static const Color cardStroke = Color(0xFF1E293B);

  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textSubtle = Color(0xFF64748B);

  static const Color live = Color(0xFFEF4444);
  static const Color success = Color(0xFF4ADE80);
  static const Color accent = Color(0xFF00C2FF);
  static const Color progress = Color(0xFF3B82F6);

  static const Color navActive = Color(0xFF00D1FF);
  static const Color navInactive = Color(0xFF64748B);

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [bgPrimary, bgPrimary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  const AppPalette._();
}
