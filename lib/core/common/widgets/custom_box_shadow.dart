import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class CustomBoxShadow extends StatelessWidget {
  const CustomBoxShadow({
    required this.child,
    required this.offset,
    this.padding,
    super.key,
  });

  final Offset offset;

  final Widget child;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.tertiary.withOpacity(0.2),
            blurRadius: 5,
            offset: offset,
          ),
        ],
      ),
      child: child,
    );
  }
}
