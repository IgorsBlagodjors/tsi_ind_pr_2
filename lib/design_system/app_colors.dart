import 'package:flutter/material.dart';

class AppColors {
  static final Color primary = const Color(0xFF33E4DB);

  static const Color gradientStart = Color(0xFF33E4DB);
  static const Color gradientEnd = Color(0xFF00BBD3);
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)],
  );
}
