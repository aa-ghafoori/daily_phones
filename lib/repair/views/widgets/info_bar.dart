import 'package:daily_phones/core/common/widgets/language_picker.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: context.colorScheme.secondary.withOpacity(0.2),
              ),
              child: Image.asset(
                ImageRes.backArrow,
                scale: 7.r,
              ),
            ),
            const WhiteSpace(width: 15),
            Text.rich(
              TextSpan(
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w300),
                text: 'Welk',
                children: [
                  TextSpan(
                      text: ' model ', style: context.textTheme.titleMedium),
                  const TextSpan(text: 'heb je?')
                ],
              ),
            ),
          ],
        ),
        const LanguagePicker()
      ],
    );
  }
}
