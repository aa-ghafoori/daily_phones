import 'package:daily_phones/core/common/widgets/repair_item.dart';
import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/on_boarding/views/widgets/repair_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Repairs extends StatelessWidget {
  const Repairs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Reparaties', style: context.textTheme.titleMedium),
            RoundButton(
              text: Row(
                children: [
                  const Text('Alle Reparaties'),
                  const WhiteSpace(width: 5),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.sp,
                    color: context.colorScheme.background,
                  ),
                ],
              ),
            ),
          ],
        ),
        const WhiteSpace(height: 10),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                  color: context.colorScheme.onBackground.withOpacity(0.2)),
            ],
            borderRadius: BorderRadius.circular(90.r),
          ),
          child: TextField(
            style: context.textTheme.bodyMedium
                ?.copyWith(color: context.colorScheme.tertiary),
            decoration: InputDecoration(
              suffixIcon: CircleAvatar(
                radius: 20.r,
                backgroundColor: context.colorScheme.secondary,
                child: Icon(
                  Icons.search_outlined,
                  color: context.colorScheme.background,
                ),
              ),
              suffixIconConstraints:
                  BoxConstraints(minHeight: 0, minWidth: 55.w),
              hintText: 'Zoek je merk, model of modelcode',
              filled: true,
              fillColor: context.colorScheme.background,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.r),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.r),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.r),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
            ),
          ),
        ),
        const RepairItem(image: ImageRes.spDp, text: 'Smartphone'),
        const RepairItem(image: ImageRes.tabletDp, text: 'iPads/Tablet'),
        const RepairItem(image: ImageRes.laptopDp, text: 'Mac/Windows'),
        const RepairItem(image: ImageRes.smartwatchDp1, text: 'Smartwatch'),
        const WhiteSpace(height: 70),
        const RepairSteps(),
      ],
    );
  }
}
