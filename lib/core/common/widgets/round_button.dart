import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
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
        padding: EdgeInsets.symmetric(horizontal: 13.r, vertical: 9.r),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        backgroundColor: backgroundColor ?? context.colorScheme.onPrimary,
        side: const BorderSide(color: Colors.transparent),
      ),
      onPressed: onPressed,
      child: DefaultTextStyle.merge(
        child: text,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.colorScheme.surface,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
