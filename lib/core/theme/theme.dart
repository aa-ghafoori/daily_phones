import 'package:daily_phones/core/res/app_colors.dart';
import 'package:daily_phones/core/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyPhonesTheme {
  DailyPhonesTheme._();
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: Fonts.poppins,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        labelSmall: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w200),
        labelMedium: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w300),
        labelLarge: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w300),
        bodySmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
        bodyMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w800),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.seedColor,
        onPrimary: AppColors.actionButtonColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        tertiary: AppColors.tertiaryColor,
        surface: AppColors.backgroundColor,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    );
  }
}
