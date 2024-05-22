import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({this.text1, this.text2, super.key});

  final String? text1;
  final String? text2;

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
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w300),
            text: text1,
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: text2,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
