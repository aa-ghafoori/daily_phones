import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/core/common/widgets/custom_snackbar.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/views/booking_screen.dart';
import 'package:daily_phones/src/repair/presentation/widgets/offer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.selectedItems, super.key});

  final List<CheckoutItem> selectedItems;

  void _checkBeforeSubmission(BuildContext context, VoidCallback onSuccess) {
    final currentState = context.read<RepairBloc>().state;

    if (currentState.selectedItems.isNotEmpty &&
        currentState.selectedColor != null) {
      onSuccess();
    } else {
      CustomSnackbar(
        context: context,
        title: 'Warning!',
        message: 'Please select at least one repair and a color.',
        contentType: ContentType.warning,
      ).show();
    }
  }

  void _showFormDialog(BuildContext context) {
    showDialog<Widget>(
      context: context,
      builder: (_) {
        return OfferForm(parentContext: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomActionButton(
          onPressed: () =>
              _checkBeforeSubmission(context, () => _showFormDialog(context)),
          backgroundColor: context.colorScheme.secondary.withOpacity(0.15),
          title: 'Send Offer PDF',
          subtitle: 'Directly in your mailbox',
          titleColor: context.colorScheme.secondary,
          subtitleColor: context.colorScheme.secondary,
        ),
        const WhiteSpace(height: 15),
        CustomActionButton(
          onPressed: () => _checkBeforeSubmission(
            context,
            () {
              final currentState = context.read<RepairBloc>().state;
              context.navigator.pushNamed(
                BookingScreen.routeName,
                arguments: currentState,
              );
            },
          ),
          backgroundColor: context.colorScheme.secondary,
          title: 'Next Step',
          subtitle: 'You only pay after your repair',
          titleColor: context.colorScheme.surface,
          subtitleColor: context.colorScheme.surface,
        ),
      ],
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
    this.child,
    super.key,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RectangularButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      text: Center(
        child: child != null
            ? child!
            : Column(
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
