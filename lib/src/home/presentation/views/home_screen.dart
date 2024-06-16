import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/src/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: const Column(
          children: [
            CardCollection(),
            WhiteSpace(height: 30),
            Repairs(),
          ],
        ),
      ),
    );
  }
}
