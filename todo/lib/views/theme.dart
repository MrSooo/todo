import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Color(0xFF4e5ae8),
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: Colors.grey[800],
    primaryColor: Colors.grey[800],
    brightness: Brightness.dark,
  );
}

TextStyle get headingTextStyle => GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

TextStyle get titleTextStyle => GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

TextStyle get titleTextFormStyle => GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
      ),
    );
