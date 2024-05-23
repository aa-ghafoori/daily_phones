import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/views/widgets/custom_search_bar.dart';
import 'package:daily_phones/repair/views/widgets/custom_stepper.dart';
import 'package:daily_phones/repair/views/widgets/info_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDevice extends StatefulWidget {
  const SearchDevice({super.key});

  @override
  State<SearchDevice> createState() => _SearchDeviceState();
}

class _SearchDeviceState extends State<SearchDevice> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomStepper(activeStep: 0),
            const WhiteSpace(height: 30),
            InfoBar(title: title),
            const WhiteSpace(height: 20),
            const CustomSearchBar(),
          ],
        ),
      ),
    );
  }

  Text get title => Text.rich(
        TextSpan(
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w300),
          text: 'Welk',
          children: [
            TextSpan(text: ' model ', style: context.textTheme.titleMedium),
            const TextSpan(text: 'heb je?')
          ],
        ),
      );
}