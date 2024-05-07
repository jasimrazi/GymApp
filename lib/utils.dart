import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Primary and Secondary Texts
class AppFonts {
  static TextStyle primaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static TextStyle secondaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

//Custom Textstyle
TextStyle fontStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.rethinkSans(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

//Custom Apptheme
class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark, // Set overall dark theme
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black, // Set background color for all pages
    elevatedButtonTheme: ElevatedButtonThemeData(
      
    )
  );
}
