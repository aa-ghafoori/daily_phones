import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    required this.text,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final Widget text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor ?? context.colorScheme.primary,
        foregroundColor: textColor ?? context.colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        side: const BorderSide(color: Colors.transparent),
      ),
      onPressed: () {},
      child: CustomText(text: text),
    );
  }
}
