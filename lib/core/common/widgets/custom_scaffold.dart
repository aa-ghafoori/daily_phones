import 'package:daily_phones/core/common/widgets/custom_app_bar.dart';
import 'package:daily_phones/core/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(),
      endDrawer: const Drawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(child: body),
    );
  }
}
