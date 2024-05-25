import 'package:daily_phones/core/common/widgets/custom_app_bar.dart';
import 'package:daily_phones/core/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:daily_phones/core/common/widgets/custom_drawer.dart';
import 'package:daily_phones/core/common/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    this.controller,
    super.key,
  });

  final List<Widget> body;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      endDrawer: const Drawer(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: SafeArea(
          child: ListView(
        controller: controller,
        padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
        children: [...body, const Footer()],
      )),
    );
  }
}
