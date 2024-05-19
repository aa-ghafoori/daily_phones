import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme {
  MyTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        labelSmall: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w100),
        labelMedium: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200),
        labelLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
        bodySmall: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w300),
        bodyMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.w800),
        headlineLarge: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.w800),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: const Color.fromARGB(255, 238, 154, 52),
        secondary: const Color.fromARGB(255, 62, 126, 216),
        background: Colors.white,
      ),
    );
  }
}
