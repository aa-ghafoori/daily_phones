import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/on_boarding/views/widgets/card_collection.dart';
import 'package:daily_phones/on_boarding/views/widgets/repairs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ColoredBox(
        color: context.colorScheme.onBackground.withOpacity(0.05),
        child: ListView(
          padding: EdgeInsets.all(12.h),
          children: const [
            CardCollection(),
            WhiteSpace(height: 30),
            Repairs(),
            WhiteSpace(height: 60),
          ],
        ),
      ),
    );
  }
}
