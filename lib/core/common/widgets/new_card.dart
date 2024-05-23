import 'package:daily_phones/select_repairs/app/list_key_provider.dart';
import 'package:daily_phones/select_repairs/app/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewCard extends ConsumerWidget {
  final Widget child;
  final dynamic item;
  final VoidCallback? onTap;

  const NewCard({super.key, required this.child, this.item, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productNotifierProvider);
    final selectedItems = state.selectedItems;
    final isSelected = item != null && selectedItems.contains(item);

    return GestureDetector(
      onTap: () {
        if (item != null) {
          final notifier = ref.read(productNotifierProvider.notifier);
          if (isSelected) {
            notifier.removeItem(item);
            ref
                .read(listKeyProvider.notifier)
                .removeItem(state.selectedItems.indexOf(item), item);
          } else {
            notifier.addItem(item);
            final index = selectedItems.length;
            ref.read(listKeyProvider.notifier).addItem(index, item);
            if (onTap != null) {
              onTap!();
            }
          }
        }
      },
      child: AnimatedContainer(
        duration: Durations.medium1,
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
