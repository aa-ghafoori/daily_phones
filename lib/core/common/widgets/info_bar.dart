import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.navigator.pop(),
                child: Container(
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
              ),
              const WhiteSpace(width: 15),
              Expanded(child: title),
            ],
          ),
        ),
        const LanguagePicker(),
      ],
    );
  }
}
