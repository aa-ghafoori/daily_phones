import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/widgets.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RectangularButton(
          backgroundColor: context.colorScheme.secondary.withOpacity(0.15),
          text: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Send Offer PDF',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.secondary,
                  ),
                ),
                Text(
                  'Directly in your mailbox',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.secondary.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
        const WhiteSpace(height: 15),
        RectangularButton(
          backgroundColor: context.colorScheme.secondary,
          text: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Next Step',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.background,
                  ),
                ),
                Text(
                  'You only pay after your repair',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.background.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
