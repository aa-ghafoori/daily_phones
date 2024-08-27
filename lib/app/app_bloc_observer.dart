import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // Number of method calls to display
  ),
);

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logger.i(
        'onChange(${bloc.runtimeType}, Current State:${change.currentState}, '
        '\u001b[1;32m Next State:${change.nextState})');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    logger.e('onError(${bloc.runtimeType}, \u001b[1;31m$error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
