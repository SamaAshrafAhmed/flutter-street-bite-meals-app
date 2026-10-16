import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF8B5E3C);
  static const Color primaryDark = Color(0xFF4A2C20);
  static const Color secondary = Color(0xFFD39B62);
  static const Color cream = Color(0xFFFFF8F0);
  static const Color darkSurface = Color(0xFF241812);

  // ── Card gradient ─────────────────────────────────────────────────────────
  static const List<Color> cardGradient = [primaryDark, primary];

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color deposit = Colors.green;
  static const Color withdraw = Colors.red;
  static const Color error = Color(0xFFB3261E);
  static const Color success = Color(0xFF527A52);
  static const Color successAccent = Color(0xFF9BC59B);

  // ── Text / Surface ────────────────────────────────────────────────────────
  static const Color textOnCard = Colors.white;
  static const Color textOnCardMuted = Colors.white70;
  static const Color textMuted = Color(0xFF806F65);
  static const Color blackColor = Color(0xFF2B211D);
}
