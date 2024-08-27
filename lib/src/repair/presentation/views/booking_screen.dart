import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/booking_form.dart';
import 'package:daily_phones/src/repair/presentation/widgets/delivery_methods.dart';
import 'package:daily_phones/src/repair/presentation/widgets/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({required this.state, super.key});

  static const routeName = '/booking';

  final RepairState state;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.focusScope.unfocus,
      child: CustomScaffold(
        controller: _scrollController,
        body: Container(
          color: context.colorScheme.surface,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const WhiteSpace(height: 40),
              const CustomStepper(activeStep: 2),
              const WhiteSpace(height: 40),
              const _Header(),
              const WhiteSpace(height: 40),
              DeliveryMethods(controller: _scrollController),
              const WhiteSpace(height: 40),
              _BookingSummary(state: widget.state, context: context),
              const WhiteSpace(height: 20),
              BookingForm(state: widget.state),
              const WhiteSpace(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return InfoBar(
      child: RichText(
        text: TextSpan(
          text: 'Finalize ',
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w300,
          ),
          children: const [
            TextSpan(
              text: 'booking',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingSummary extends StatelessWidget {
  const _BookingSummary({required this.state, required this.context});

  final RepairState state;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final totalPrice = getTotal(state.selectedItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductDetails(product: state.product!),
        const WhiteSpace(height: 30),
        Text(
          '${state.product!.name} ${state.selectedColor!.name}',
          style: context.textTheme.labelLarge?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const WhiteSpace(height: 10),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: context.textTheme.titleMedium),
                Text(
                  'incl. 21% Tax',
                  style: context.textTheme.labelLarge,
                ),
              ],
            ),
            const Spacer(),
            Text(
              '€ $totalPrice',
              style:
                  context.textTheme.headlineMedium?.copyWith(fontSize: 30.sp),
            ),
          ],
        ),
        Divider(height: 50.h, thickness: 0.6),
        // Builder(
        //   builder: (context) {
        //     String? info;
        //     String? details;
        //     final selectedDeliveryData =
        //         context.watch<RepairBloc>().selectedDeliveryData;
        //     if (selectedDeliveryData?['method'] == 'ship_device') {
        //       info = 'Ship Device';
        //     } else if (selectedDeliveryData?['method'] == 'come_by_our_store') {
        //       info = 'Come by our store';
        //       if (selectedDeliveryData?.length == 4) {
        //         details =
        //             'Appointment on ${selectedDeliveryData!['date']} at ${selectedDeliveryData!['time']}';
        //       }
        //     }
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           info ?? '',
        //           style: context.textTheme.labelMedium,
        //         ),
        //         Text(
        //           details ?? '',
        //           style: context.textTheme.bodySmall?.copyWith(
        //             color: context.colorScheme.secondary,
        //           ),
        //         )
        //       ],
        //     );
        //   },
        // ),
      ],
    );
  }
}
