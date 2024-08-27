import 'package:daily_phones/core/common/widgets/custom_app_bar.dart';
import 'package:daily_phones/core/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:daily_phones/core/common/widgets/custom_drawer.dart';
import 'package:daily_phones/core/common/widgets/footer.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    this.controller,
    super.key,
  });

  final Widget body;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      endDrawer: Drawer(
        backgroundColor: context.colorScheme.surface,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          padding: EdgeInsets.only(top: 15.h),
          child: Column(children: [body, const Footer()]),
        ),
      ),
    );
  }
}
