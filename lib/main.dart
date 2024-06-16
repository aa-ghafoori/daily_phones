import 'dart:async';
import 'dart:developer';

import 'package:daily_phones/app/app.dart';
import 'package:daily_phones/app/app_bloc_observer.dart';
import 'package:daily_phones/core/services/injection_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    init();

    FlutterError.onError = (details) =>
        log(details.exceptionAsString(), stackTrace: details.stack);

    Bloc.observer = const AppBlocObserver();

    runApp(const App());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
