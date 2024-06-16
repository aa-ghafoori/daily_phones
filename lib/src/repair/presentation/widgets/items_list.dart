import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/src/repair/domain/entities/checkout_item.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({required this.selectedItems, super.key});

  final List<CheckoutItem> selectedItems;

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  late List<CheckoutItem> _items;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    _items = widget.selectedItems;
    super.initState();
  }

  void _handleItemUpdates(List<CheckoutItem> currentItems) {
    if (currentItems.length > _items.length) {
      final missingItems =
          currentItems.where((item) => !_items.contains(item)).toList();

      if (missingItems.isNotEmpty) {
        for (final item in missingItems) {
          final index = currentItems.indexOf(item);
          _items = List.from(currentItems);
          Future.delayed(
              const Duration(milliseconds: 500),
              () => _listKey.currentState
                  ?.insertItem(index, duration: Durations.short3));
        }
      }
    }

    if (currentItems.length < _items.length) {
      final removedItem =
          _items.firstWhere((item) => !currentItems.contains(item));
      final index = _items.indexOf(removedItem);
      _listKey.currentState?.removeItem(
        index,
        duration: Durations.short3,
        (context, animation) => _CheckoutItemWidget(
          item: removedItem,
          animation: animation,
        ),
      );
      _items = List.from(currentItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedItems.length != _items.length) {
      _handleItemUpdates(widget.selectedItems);
    }

    return AnimatedList(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return _CheckoutItemWidget(
          item: _items[index],
          animation: animation,
        );
      },
    );
  }
}

class _CheckoutItemWidget extends StatelessWidget {
  const _CheckoutItemWidget({
    required this.item,
    required this.animation,
  });

  final CheckoutItem item;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final isAdding = animation.status != AnimationStatus.dismissed;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: isAdding ? Curves.easeOut : Curves.easeInOut,
        ),
      ),
      child: Row(
        children: [
          const WhiteSpace(height: 45),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () =>
                context.read<RepairBloc>().add(RepairItemRemoved(item)),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                ImageRes.close,
                height: 10.w,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.secondary.withOpacity(0.4),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const WhiteSpace(width: 30),
          Text(
            item.name,
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
                item.price.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.background,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
