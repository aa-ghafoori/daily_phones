import 'package:daily_phones/core/res/constants.dart';
import 'package:daily_phones/select_repairs/app/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorCard extends ConsumerWidget {
  final Widget child;
  final SmartphoneColor item;

  const ColorCard({super.key, required this.child, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productNotifierProvider);
    final isSelected = state.selectedColor == item;

    return GestureDetector(
      onTap: () {
        final notifier = ref.read(productNotifierProvider.notifier);
        notifier.setSelectedColor(item);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.2),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
