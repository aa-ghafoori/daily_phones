import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';

class RepairItem extends StatelessWidget {
  const RepairItem({required this.image, required this.text, super.key});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        const WhiteSpace(height: 30),
        CustomText(text: Text(text, style: context.textTheme.titleMedium))
      ],
    );
  }
}
