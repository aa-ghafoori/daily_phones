import 'package:daily_phones/core/common/widgets/new_card.dart';
import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/secondary_button.dart';
import 'package:daily_phones/core/common/widgets/top_shadow_container.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/select_repairs/app/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairSummary extends ConsumerWidget {
  const RepairSummary(
      {required this.title, required this.selectedItems, super.key});

  final String title;
  final List selectedItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = selectedItems.fold<double>(
        0, (total, item) => total + (double.parse(item.price)));

    String numberString = totalPrice.toStringAsFixed(2);
    List<String> parts = numberString.split('.');
    String decimalPart = parts.length > 1 ? parts[1] : '';

    return TopShadowContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Repair List',
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.colorScheme.secondary),
          ),
          const WhiteSpace(height: 10),
          Text(title.toUpperCase()),
          const WhiteSpace(height: 15),
          Column(
            children: selectedItems
                .map((item) =>
                    _buildCheckoutItem(item: item, context: context, ref: ref))
                .toList(),
          ),
          Divider(
            color: context.colorScheme.onBackground.withOpacity(0.05),
            height: 50.h,
          ),
          Row(
            children: [
              Text(
                'Sub-total',
                style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 15.sp,
                    color: context.colorScheme.onBackground.withOpacity(0.7)),
              ),
              const Spacer(),
              SizedBox(
                  width: 0.17.sw,
                  child: Center(
                      child: Text(
                    numberString,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ))),
            ],
          ),
          const WhiteSpace(height: 15),
          Row(
            children: [
              SizedBox(
                width: 0.5.sw,
                child: NewCard(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'Coupon Code',
                        hintStyle: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          color:
                              context.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const WhiteSpace(width: 10),
              SecondaryButton(
                backgroundColor:
                    context.colorScheme.secondary.withOpacity(0.15),
                icon: Icon(
                  Icons.add,
                  size: 18,
                  color: context.colorScheme.secondary,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
              ),
            ],
          ),
          Divider(
            color: context.colorScheme.onBackground.withOpacity(0.05),
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    'incl. tax (21%)',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color:
                            context.colorScheme.onBackground.withOpacity(0.7)),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '€',
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    parts[0],
                    style: context.textTheme.headlineMedium,
                    strutStyle: const StrutStyle(
                        forceStrutHeight: true, height: 1.8, leading: 1.5),
                  ),
                  Text(
                    decimalPart != '0' ? decimalPart : '',
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: context.colorScheme.onBackground.withOpacity(0.05),
            height: 30.h,
          ),
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
                        color: context.colorScheme.secondary.withOpacity(0.9),
                        fontSize: 16.sp),
                  ),
                  Text(
                    'Directly in your mailbox',
                    style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.secondary.withOpacity(0.8)),
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
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.background.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    'You only pay after your repair',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const WhiteSpace(height: 40),
        ],
      ),
    );
  }

  Widget _buildCheckoutItem(
      {required dynamic item,
      required BuildContext context,
      required WidgetRef ref}) {
    return Row(
      children: [
        const WhiteSpace(height: 45),
        GestureDetector(
          onTap: () =>
              ref.read(productNotifierProvider.notifier).removeItem(item),
          child: Icon(
            CupertinoIcons.xmark,
            size: 14,
            color: context.colorScheme.secondary.withOpacity(0.8),
          ),
        ),
        const WhiteSpace(width: 30),
        Text(
          item.title,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          width: 0.17.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: context.colorScheme.secondary,
          ),
          child: Center(
            child: Text(
              item.price,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.background,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
