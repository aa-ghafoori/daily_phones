import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    required this.text,
    this.backgroundColor,
    this.onPressed,
    super.key,
  });

  final Widget text;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
        backgroundColor: backgroundColor ?? context.colorScheme.surface,
        side: const BorderSide(color: Colors.transparent),
      ),
      onPressed: onPressed,
      child: DefaultTextStyle.merge(
        child: text,
        style:
            context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
