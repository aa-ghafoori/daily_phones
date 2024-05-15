import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({required this.text, super.key});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      child: text,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.onBackground,
      ),
    );
  }
}
