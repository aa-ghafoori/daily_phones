import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  MyTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.lexendDeca().fontFamily,
      textTheme: TextTheme(
        labelLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        labelMedium: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
        labelSmall: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800),
        titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
        titleSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
        headlineLarge: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w800),
        headlineSmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: const Color.fromARGB(245, 253, 149, 46),
        secondary: const Color.fromARGB(245, 2, 131, 217),
        background: Colors.white,
      ),
    );
  }
}
