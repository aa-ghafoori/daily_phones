import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({required this.child, this.onTap, super.key});

  final Widget child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: onTap ?? () => context.navigator.pop(),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.colorScheme.secondary.withOpacity(0.2),
                  ),
                  child: Image.asset(
                    ImageRes.backArrow,
                    scale: 7 * (1 / 1.h),
                  ),
                ),
              ),
              const WhiteSpace(width: 15),
              Expanded(child: child),
            ],
          ),
        ),
        const LanguagePicker(),
      ],
    );
  }
}
