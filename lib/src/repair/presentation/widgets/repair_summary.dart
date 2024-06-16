import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/action_buttons.dart';
import 'package:daily_phones/src/repair/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairSummary extends StatelessWidget {
  const RepairSummary({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final items = context.select((RepairBloc bloc) => bloc.state.selectedItems);
    final totalPrice =
        items.fold<double>(0, (total, item) => total + item.price);

    final numberString = totalPrice.toStringAsFixed(2);
    final parts = numberString.split('.');
    final decimalPart = parts.length > 1 ? parts[1] : '';

    return OverflowBox(
      fit: OverflowBoxFit.deferToChild,
      maxWidth: 1.sw,
      child: CustomBoxShadow(
        offset: const Offset(0, -1),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryHeader(context),
            const WhiteSpace(height: 10),
            _buildProductInfo(context),
            const WhiteSpace(height: 15),
            ItemsList(selectedItems: items),
            Divider(height: 50.h, thickness: 0),
            _buildSubtotal(context, numberString),
            const WhiteSpace(height: 15),
            const _CouponCodeField(),
            Divider(height: 30.h, thickness: 0),
            _buildTotal(context, parts, decimalPart),
            Divider(height: 30.h, thickness: 0),
            const ActionButtons(),
            const WhiteSpace(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryHeader(BuildContext context) {
    return Text(
      'Repair List',
      style: context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.secondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Text(
      '${product.brand} ${product.name}'.toUpperCase(),
      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
    );
  }

  Widget _buildSubtotal(BuildContext context, String numberString) {
    return Row(
      children: [
        Text(
          'Sub-total',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 15.sp,
            color: context.colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 0.17.sw,
          child: Center(
            child: Text(
              numberString,
              style: context.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotal(
    BuildContext context,
    List<String> parts,
    String decimalPart,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                color: context.colorScheme.onBackground.withOpacity(0.7),
              ),
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
                forceStrutHeight: true,
                height: 1.8,
                leading: 1.5,
              ),
            ),
            Text(
              int.parse(decimalPart) > 0 ? decimalPart : '',
            ),
          ],
        ),
      ],
    );
  }
}

class _CouponCodeField extends StatelessWidget {
  const _CouponCodeField();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 0.5.sw,
          child: ItemCard(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              child: TextField(
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w300),
                cursorWidth: 1,
                cursorColor: context.colorScheme.onBackground,
                decoration: InputDecoration(
                  hintText: 'Coupon Code',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                  isCollapsed: true,
                ),
              ),
            ),
          ),
        ),
        const WhiteSpace(width: 10),
        SecondaryButton(
          backgroundColor: context.colorScheme.secondary.withOpacity(0.15),
          icon: Icon(
            Icons.add,
            size: 18,
            color: context.colorScheme.secondary,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        ),
      ],
    );
  }
}
