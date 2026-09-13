import 'package:flutter/material.dart';

/// App color palette for Draw Easy
abstract class AppColors {
  // Primary brand color – warm coral/orange
  static const Color primary = Color(0xFFE8673A);
  static const Color primaryLight = Color(0xFFF0886A);
  static const Color primaryDark = Color(0xFFD04E22);

  // Background & surface
  static const Color background = Color(0xFFFAF9F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F4F1);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // Hero section gradient
  static const Color heroGradientStart = Color(0xFFFFF0E8);
  static const Color heroGradientEnd = Color(0xFFEEF0FF);

  // Accent ring colors for hero illustration
  static const Color ringOuter = Color(0xFFFFD6C4);
  static const Color ringInner = Color(0xFFFFC4A8);

  // Tag chip colors
  static const Color chipBackground = Color(0xFFFFFFFF);
  static const Color chipBorder = Color(0xFFE5E7EB);
  static const Color chipGreen = Color(0xFF10B981);
  static const Color chipBlue = Color(0xFF3B82F6);
  static const Color chipPurple = Color(0xFF8B5CF6);

  // Dot indicator
  static const Color dotActive = Color(0xFFE8673A);
  static const Color dotInactive = Color(0xFFD1D5DB);

  // Badge / new indicator
  static const Color badgeRed = Color(0xFFEF4444);

  // Feature card icon background
  static const Color iconBgPink = Color(0xFFFFF0EC);
  static const Color iconBgGreen = Color(0xFFECFDF5);
  static const Color iconBgPurple = Color(0xFFF5F3FF);

  // ── Auth screens ─────────────────────────────────────────────────────────
  static const Color authBackground = Color(0xFFF0F0FA);
  static const Color fieldFill = Color(0xFFEEEEF8);
  static const Color fieldBorder = Color(0xFFDDDDEE);
  static const Color fieldFocusBorder = Color(0xFFE8673A);
  static const Color dividerColor = Color(0xFFDDDDEE);

  // Social buttons
  static const Color googleBtnBg = Color(0xFFFFFFFF);
  static const Color appleBtnBg = Color(0xFF1C1C2E);

  // Password strength
  static const Color strengthWeak = Color(0xFFEF4444);
  static const Color strengthFair = Color(0xFFF59E0B);
  static const Color strengthGood = Color(0xFF10B981);
  static const Color strengthStrong = Color(0xFF059669);
  static const Color strengthEmpty = Color(0xFFDDDDEE);

  // Checkbox
  static const Color checkboxActive = Color(0xFFE8673A);

  // Journey badge
  static const Color journeyBadgeBg = Color(0xFFFFF0E8);
  static const Color journeyBadgeText = Color(0xFFE8673A);

  // Success / info
  static const Color successGreen = Color(0xFF10B981);
  static const Color successBg = Color(0xFFECFDF5);
  static const Color infoBlueBg = Color(0xFFEFF6FF);
  static const Color infoBlue = Color(0xFF3B82F6);
}
