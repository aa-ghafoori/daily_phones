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
                  _buildHeader(context),
                  const WhiteSpace(height: 15),
                  Text(repair.description, style: context.textTheme.labelLarge),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _buildPriceTag(context, isSelected),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Image.asset(repair.iconUrl, scale: 10),
        const WhiteSpace(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repair.title,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '${repair.durationInMinutes} MINUTES',
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

  Widget _buildPriceTag(BuildContext context, bool isSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: isSelected
          ? _buildSelectedPriceTag(context)
          : _buildUnselectedPriceTag(context),
    );
  }

  List<Widget> _buildSelectedPriceTag(BuildContext context) {
    return [
      Container(
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
                color: context.colorScheme.background,
              ),
            ),
            Text(
              repair.price.toStringAsFixed(0),
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.background,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildUnselectedPriceTag(BuildContext context) {
    return [
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
            color: context.colorScheme.background,
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
    ];
  }
}
