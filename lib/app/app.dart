import 'package:daily_phones/core/services/router.dart';
import 'package:daily_phones/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

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
            theme: DailyPhonesTheme.lightTheme,
            onGenerateRoute: generateRoute,
          );
        });
  }
}
