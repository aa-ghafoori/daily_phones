import 'dart:async';
import 'dart:developer';

import 'package:daily_phones/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_mobile_devices_api/sqflite_mobile_devices_api.dart';
import 'core/res/predefined_data.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final mobileDevicesApi = SqfliteMobileDevicesApi();

    await mobileDevicesApi.seedDatabase(
      predefinedBrands: predefinedBrands,
      predefinedProducts: predefinedProducts,
      predefinedAccessories: predefinedAccessories,
      predefinedRepairs: predefinedRepairs,
      predefinedColors: predefinedColors,
    );

    bootstrap(mobileDevicesApi: mobileDevicesApi);
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
