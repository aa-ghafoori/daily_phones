import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairStepsItem extends StatelessWidget {
  const RepairStepsItem(
      {required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WhiteSpace(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Image.asset(ImageRes.check, scale: 6.sp),
            ),
            const WhiteSpace(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: context.colorScheme.background),
                  ),
                  const WhiteSpace(height: 5),
                  Text(
                    description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.background),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
