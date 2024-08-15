import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairOption extends StatelessWidget {
  const RepairOption({required this.repair, super.key});

  final Repair repair;

  @override
  Widget build(BuildContext context) {
    final item = CheckoutItem.fromRepair(repair);
    final isSelected = context
        .select((RepairBloc bloc) => bloc.state.selectedItems.contains(item));

    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: ItemCard(
        isSelected: isSelected,
        item: item,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(repair: repair),
                  const WhiteSpace(height: 15),
                  Text(repair.description, style: context.textTheme.labelLarge),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _PriceTag(repair: repair, isSelected: isSelected),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.repair});

  final Repair repair;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(repair.imageUrl, scale: 10),
        const WhiteSpace(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repair.name,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '${repair.duration} MINUTES',
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({required this.repair, required this.isSelected});

  final Repair repair;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? _SelectedPriceTag(repair: repair)
        : _UnselectedPriceTag(repair: repair);
  }
}

class _SelectedPriceTag extends StatelessWidget {
  const _SelectedPriceTag({required this.repair});

  final Repair repair;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        color: context.colorScheme.secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '€',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.surface,
            ),
          ),
          Text(
            repair.price.toStringAsFixed(0),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.surface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnselectedPriceTag extends StatelessWidget {
  const _UnselectedPriceTag({required this.repair});

  final Repair repair;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.r),
              topLeft: Radius.circular(7.r),
              topRight: Radius.circular(7.r),
            ),
            color: context.colorScheme.secondary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Text(
            'starting at',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.surface,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.r),
              bottomRight: Radius.circular(7.r),
            ),
            color: context.colorScheme.primary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '€',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
              Text(
                repair.price.toStringAsFixed(0),
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.secondary,
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
