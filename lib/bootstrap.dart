import 'dart:developer';

import 'package:daily_phones/app/app.dart';
import 'package:daily_phones/app/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

void bootstrap({required MobileDevicesApi mobileDevicesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final mobileDevicesRepository = MobileDevicesRepository(mobileDevicesApi);

  runApp(App(mobileDevicesRepository: mobileDevicesRepository));
}
