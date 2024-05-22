import 'package:flutter/material.dart';

class CustomTextStyle {
  static const mainAction = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: CustomColors.primary,
  );

  static const h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: CustomColors.primary,
  );

  static const h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: CustomColors.primary,
  );

  static const body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: CustomColors.primary,
  );

  static const prompt = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    color: CustomColors.prompt,
  );
}

class CustomColors {
  static const primary = Color(0xFF373D66);
  static const secondary = Color(0xFFFCBE4F);
  static const prompt = Color(0xFFd3d3d3);
}
