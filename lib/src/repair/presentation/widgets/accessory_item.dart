import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccessoryItem extends StatelessWidget {
  const AccessoryItem({required this.accessory, super.key});
  final Accessory accessory;

  @override
  Widget build(BuildContext context) {
    final item = CheckoutItem.fromAccessory(accessory);
    final isSelected = context
        .select((RepairBloc bloc) => bloc.state.selectedItems.contains(item));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: ItemCard(
        isSelected: isSelected,
        item: item,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Stack(
            children: [
              _buildAccessoryContent(context),
              Positioned(
                right: 0,
                bottom: 0,
                child: _buildPriceTag(context, isSelected, accessory.price),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessoryContent(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorScheme.secondary.withOpacity(0.5),
          height: 180,
          child: ClipRect(
            child: Image.asset(
              accessory.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const WhiteSpace(height: 10),
        Row(
          children: [
            Text(
              accessory.title,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const WhiteSpace(width: 5),
            Icon(
              CupertinoIcons.info_circle_fill,
              size: 20.w,
              color: context.colorScheme.onBackground.withOpacity(0.35),
            ),
          ],
        ),
        const WhiteSpace(height: 8),
        Text(
          accessory.description,
          style: context.textTheme.labelLarge,
        ),
      ],
    );
  }

  Widget _buildPriceTag(BuildContext context, bool isSelected, double price) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        color: isSelected
            ? context.colorScheme.secondary
            : context.colorScheme.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '€',
            style: context.textTheme.labelLarge?.copyWith(
              color: isSelected
                  ? context.colorScheme.background
                  : context.colorScheme.secondary,
            ),
          ),
          Text(
            price.toString(),
            style: context.textTheme.bodyLarge?.copyWith(
              color: isSelected
                  ? context.colorScheme.background
                  : context.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
