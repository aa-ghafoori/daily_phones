import 'package:daily_phones/core/utils/theme/theme.dart';
import 'package:daily_phones/observer.dart';
import 'package:daily_phones/on_boarding/views/on_boarding_screen.dart';
import 'package:daily_phones/select_repairs/app/cubit/list_key_cubit.dart';
import 'package:daily_phones/select_repairs/app/cubit/product_cubit.dart';
import 'package:daily_phones/repair/views/repair_screen.dart';
import 'package:daily_phones/select_repairs/views/select_repairs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  Bloc.observer = const AppObserver();
  runApp(ProviderScope(
      child: MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ProductCubit(),
      ),
      BlocProvider(
        create: (_) => ListKeyCubit(),
      ),
    ],
    child: const MyApp(),
  )));
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
            initialRoute: '/',
            routes: {
              '/': (context) => const OnBoardingScreen(),
              '/repair': (context) => const RepairScreen(),
              '/select_repair': (context) => const SelectRepairsScreen(),
            },
            debugShowCheckedModeBanner: false,
            title: 'DAILY PHONES',
            theme: MyTheme.lightTheme(context),
          );
        });
  }
}
