import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/on_boarding/widgets/card_collection.dart';
import 'package:daily_phones/on_boarding/widgets/repairs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

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
