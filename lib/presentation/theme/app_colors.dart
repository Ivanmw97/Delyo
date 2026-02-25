import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Accent ---
  static const Color accent = Color(0xFF007AFF);

  // --- Semantic (outcome) — same in both modes ---
  static const Color win    = Color(0xFF34C759);
  static const Color loss   = Color(0xFFFF3B30);
  static const Color draw   = Color(0xFF8E8E93);
  static const Color orange = Color(0xFFFF9500);

  // --- Light palette ---
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightSurface    = Color(0xFFFFFFFF);
  static const Color lightOnSurface  = Color(0xFF1D1D1F);

  // --- Dark palette ---
  static const Color darkBackground  = Color(0xFF1C1C1E);
  static const Color darkSurface     = Color(0xFF2C2C2E);
  static const Color darkOnSurface   = Color(0xFFE5E5EA);
}
