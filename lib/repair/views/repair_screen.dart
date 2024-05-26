import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/views/widgets/custom_search_bar.dart';
import 'package:daily_phones/repair/views/widgets/custom_stepper.dart';
import 'package:daily_phones/repair/views/widgets/info_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  ScrollController? _scrollController;

  void _setScrollController(ScrollController controller) {
    setState(() {
      _scrollController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(controller: _scrollController, body: [
      OverflowBox(
        fit: OverflowBoxFit.deferToChild,
        maxWidth: 1.sw,
        child: Container(
          color: context.colorScheme.background,
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomStepper(activeStep: 0),
              const WhiteSpace(height: 30),
              InfoBar(title: title),
              const WhiteSpace(height: 20),
              CustomSearchBar(
                onControllerCreated: _setScrollController,
              ),
            ],
          ),
        ),
      )
    ]);
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


// onTap: () =>
//             ref.read(searchBarNotifierProvider.notifier).handleTapOutside(),