import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    super.key,
  });

  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 13,
          color: context.colorScheme.secondary,
        ),
        const WhiteSpace(width: 10),
        Text.rich(
          TextSpan(
            style: context.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w300),
            text: text1,
            children: [
              TextSpan(
                text: text2 != null ? ' $text2 ' : null,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w300),
                text: text3,
              ),
              TextSpan(
                text: text4 != null ? ' $text4 ' : null,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w300),
                text: text5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
