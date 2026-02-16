import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF6A9C89); // Calming Green
  static const Color secondary = Color(0xFFC4DAD2); // Soft Mint
  static const Color accent = Color(0xFFE9EFEC); // Off White
  static const Color textPrimary = Color(0xFF16423C); // Dark Teal Text
  static const Color textSecondary = Color(0xFF6A9C89);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC4DAD2),
      Color(0xFF16423C),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x4DFFFFFF), // White 30%
      Color(0x1AFFFFFF), // White 10%
    ],
  );

  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x80FFFFFF), // White 50%
      Color(0x1AFFFFFF), // White 10%
    ],
  );
}
