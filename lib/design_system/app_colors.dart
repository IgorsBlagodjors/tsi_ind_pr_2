import 'package:flutter/material.dart';

class AppColors {
  static final Color primary = const Color(0xFF13CAD6);
  static final Color text2 = const Color(0xFF252525);
  static final Color elements = const Color(0xFFE9F6FE);

  static const Color gradientStart = Color(0xFF33E4DB);
  static const Color gradientEnd = Color(0xFF00BBD3);
  static const LinearGradient degradadoAzul = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)],
  );
}
