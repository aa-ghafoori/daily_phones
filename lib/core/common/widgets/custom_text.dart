import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({required this.text, super.key});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      child: text,
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onBackground,
      ),
    );
  }

  // const CustomText({
  //   required this.text,
  //   this.fontSize,
  //   this.fontWeight,
  //   this.color,
  //   this.textStyle,
  //   this.textAlign,
  //   super.key,
  // });

  // final String text;
  // final double? fontSize;
  // final FontWeight? fontWeight;
  // final Color? color;
  // final TextStyle? textStyle;
  // final TextAlign? textAlign;

  // @override
  // Widget build(BuildContext context) {
  //   return Text(
  //     textAlign: textAlign,
  //     text,
  //     style: textStyle?.copyWith(
  //           fontSize: fontSize?.sp,
  //           color: color,
  //           fontWeight: fontWeight,
  //         ) ??
  //         TextStyle(
  //           fontSize: fontSize?.sp ?? 14.sp,
  //           color: color,
  //           fontWeight: fontWeight,
  //         ),
  //   );
  // }
}
