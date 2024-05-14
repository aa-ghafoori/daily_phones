import 'package:daily_phones/core/utils/theme/theme.dart';
import 'package:daily_phones/on_boarding/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 890.3),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DAILY PHONES',
            theme: MyTheme.lightTheme(context),
            home: const OnBoardingScreen(),
          );
        });
  }
}
