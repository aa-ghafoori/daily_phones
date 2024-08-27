import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/services/email_service.dart';
import 'package:daily_phones/src/repair/domain/entities/delivery_method.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({required this.state, super.key});

  final RepairState state;

  static const routeName = '/booking-confirmation';

  @override
  Widget build(BuildContext context) {
    final currentState = state as RepairBookingSuccess;
    final appointmentDate = currentState.deliveryMethod is StorePickup
        ? (currentState.deliveryMethod as StorePickup).appointmentDate
        : DateTime.now();

    final weekDay = EmailService().formatDay(appointmentDate!);
    final date = EmailService().formatDate(appointmentDate);
    final time = EmailService().formatTime(appointmentDate);

    return CustomScaffold(
      body: Container(
        color: context.colorScheme.surface,
        margin: EdgeInsets.only(top: 30.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WhiteSpace(height: 40),
            const CustomStepper(activeStep: 4),
            const WhiteSpace(height: 40),
            Center(
              child: Text(
                'Congratulations!',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      context.colorScheme.secondary, // Base color for shimmer
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                  duration: 1500.ms,
                  color: context
                      .colorScheme.onPrimary, // Highlight color for shimmer
                ),
            const WhiteSpace(height: 40),
            Text(
              'Booking was Successful.',
              style: context.textTheme.titleSmall,
            ),
            const WhiteSpace(height: 10),
            Text(
              'Please check your email for booking details.',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.tertiary,
              ),
            ),
            const WhiteSpace(height: 40),
            Text(
              currentState.deliveryMethod is StorePickup
                  ? 'Come to our store:'
                  : 'Send device to:',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const WhiteSpace(height: 10),
            RichText(
              text: TextSpan(
                text: currentState.deliveryMethod is StorePickup
                    ? 'Your appointment is on '
                    : 'Payment Method: ',
                style: context.textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: currentState.deliveryMethod is StorePickup
                        ? '$weekDay, $date, $time'
                        : 'Pay after repair',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: currentState.deliveryMethod is StorePickup
                          ? context.colorScheme.secondary
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            const WhiteSpace(height: 40),
            Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'ADDRESS DETAILS',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const WhiteSpace(height: 10),
                    Text(
                      'Daily Phones | Dokkum',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const WhiteSpace(height: 10),
                    Text(
                      'Waagstraat 14A,\n 9101 LC Dokkum',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(height: 40),
          ],
        ),
      ),
    );
  }
}
