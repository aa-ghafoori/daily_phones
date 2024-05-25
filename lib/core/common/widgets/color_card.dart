import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/select_repairs/app/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorCard extends ConsumerWidget {
  final Widget child;
  final SmartphoneColor item;
  final ProductState? state;

  const ColorCard({
    super.key,
    required this.child,
    required this.item,
    this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = state != null && (state!.selectedColor == item);

    return GestureDetector(
      onTap: () {
        final notifier = context.read<ProductCubit>();
        notifier.setSelectedColor(item);
      },
      child: AnimatedContainer(
        duration: Durations.short2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
