import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.backgroundColor,
    this.icon,
    this.padding,
  });

  final Color? backgroundColor;
  final Icon? icon;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
          color: backgroundColor ?? context.colorScheme.secondary,
        ),
        child: icon ??
            Icon(
              Icons.arrow_back_ios,
              size: 13.w,
              color: context.colorScheme.background,
            ),
      ),
    );
  }
}
