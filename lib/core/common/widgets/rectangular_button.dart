import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    required this.text,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
          elevation: 0,
          backgroundColor: backgroundColor ?? context.colorScheme.background,
          foregroundColor: textColor ?? context.colorScheme.onBackground,
          side: const BorderSide(color: Colors.transparent)),
      onPressed: () {},
      child: CustomText(
        text: text,
        textStyle: context.textTheme.bodySmall,
      ),
    );
  }
}
