import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    super.key,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
          foregroundColor: textColor ?? context.colorScheme.background,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          side: const BorderSide(color: Colors.transparent),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: Text(
                text,
                style: TextStyle(
                    color: context.colorScheme.background,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (icon != null) const WhiteSpace(width: 5),
            if (icon != null) icon!,
          ],
        ));
  }
}
