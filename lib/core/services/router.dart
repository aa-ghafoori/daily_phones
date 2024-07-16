import 'package:daily_phones/core/common/views/page_under_construction.dart';
import 'package:daily_phones/core/services/injection_container.dart';
import 'package:daily_phones/src/home/presentation/views/views.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return _pageRouteBuilder(
        (_) => const HomeScreen(),
        settings: settings,
      );
    case DevicesScreen.routeName:
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (_) => sl<RepairBloc>()..add(RepairStarted()),
          child: const DevicesScreen(),
        ),
        settings: settings,
      );
    case RepairScreen.routeName:
      final product = settings.arguments! as Product;
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (context) =>
              sl<RepairBloc>()..add(RepairProductSelected(product: product)),
          child: RepairScreen(product: product),
        ),
        settings: settings,
      );
    default:
      return _pageRouteBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

MaterialPageRoute<dynamic> _pageRouteBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) =>
    MaterialPageRoute(builder: (context) => page(context), settings: settings);
