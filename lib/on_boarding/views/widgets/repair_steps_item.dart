import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';

class RepairStepsItem extends StatelessWidget {
  const RepairStepsItem(
      {required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.asset(ImageRes.check, scale: 4),
        ),
        const WhiteSpace(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium
                    ?.copyWith(color: context.colorScheme.background),
              ),
              const WhiteSpace(height: 10),
              Text(
                description,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.colorScheme.background),
              ),
            ],
          ),
        )
      ],
    );
  }
}
