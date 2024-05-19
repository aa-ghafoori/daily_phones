import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/views/widgets/custom_search_bar.dart';
import 'package:daily_phones/repair/views/widgets/custom_stepper.dart';
import 'package:daily_phones/repair/views/widgets/grid_list.dart';
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
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStepper(),
            WhiteSpace(height: 30),
            InfoBar(),
            WhiteSpace(height: 20),
            CustomSearchBar(),
            GridList(),
          ],
        ),
      ),
    );
  }
}
