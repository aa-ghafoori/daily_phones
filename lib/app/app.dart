import 'package:daily_phones/on_boarding/view/on_boarding_screen.dart';
import 'package:daily_phones/devices/view/devices_screen.dart';
import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:daily_phones/repair/view/repair_screen.dart';
import 'package:daily_phones/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

class App extends StatelessWidget {
  const App({required this.mobileDevicesRepository, super.key});

  final MobileDevicesRepository mobileDevicesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: mobileDevicesRepository,
      child: BlocProvider(
        create: (_) =>
            RepairBloc(mobileDevicesRepository: mobileDevicesRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
              '/devices': (context) => const DevicesScreen(),
              '/repair': (context) => const RepairScreen(),
            },
            debugShowCheckedModeBanner: false,
            title: 'DAILY PHONES',
            theme: DailyPhonesTheme.lightTheme,
          );
        });
  }
}
