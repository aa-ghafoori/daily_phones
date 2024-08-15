import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/widgets/offer_form.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.selectedItems, super.key});

  final List<CheckoutItem> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomActionButton(
          onPressed: () {
            _showFormDialog(context);
          },
          backgroundColor: context.colorScheme.secondary.withOpacity(0.15),
          title: 'Send Offer PDF',
          subtitle: 'Directly in your mailbox',
          titleColor: context.colorScheme.secondary,
          subtitleColor: context.colorScheme.secondary,
        ),
        const WhiteSpace(height: 15),
        CustomActionButton(
          onPressed: () {
            // Handle "Next Step" action
          },
          backgroundColor: context.colorScheme.secondary,
          title: 'Next Step',
          subtitle: 'You only pay after your repair',
          titleColor: context.colorScheme.surface,
          subtitleColor: context.colorScheme.surface,
        ),
      ],
    );
  }

  void _showFormDialog(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return OfferForm(selectedItems: selectedItems);
      },
    );
  }
}

class CustomActionButton extends StatelessWidget {

  const CustomActionButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
  });
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return RectangularButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      text: Center(
        child: Column(
          children: [
            Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            Text(
              subtitle,
              style: context.textTheme.labelMedium?.copyWith(
                color: subtitleColor.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
