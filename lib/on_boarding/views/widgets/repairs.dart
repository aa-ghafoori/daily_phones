import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
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
          children: [
            CustomText(
              text: 'Reparaties',
              textStyle: context.textTheme.titleMedium,
            ),
            const RoundButton(text: 'Alle Reparaties')
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
            style: context.textTheme.bodyLarge!.copyWith(
                color: context.colorScheme.onBackground.withOpacity(0.9)),
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
              hintStyle: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onBackground.withOpacity(0.9)),
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
        )
      ],
    );
  }
}
