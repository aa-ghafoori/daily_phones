import 'package:daily_phones/select_repairs/app/cubit/list_key_cubit.dart';
import 'package:daily_phones/select_repairs/app/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCard extends StatelessWidget {
  final Widget child;
  final dynamic item;
  final VoidCallback? onTap;
  final ProductState? state;

  const NewCard(
      {super.key, required this.child, this.item, this.onTap, this.state});

  @override
  Widget build(BuildContext context) {
    final selectedItems = state?.selectedItems;
    final isSelected =
        item != null && state != null && selectedItems!.contains(item);

    return GestureDetector(
      onTap: () {
        if (item != null && state != null) {
          final notifier = context.read<ProductCubit>();
          if (isSelected) {
            notifier.removeItem(item);
            context
                .read<ListKeyCubit>()
                .removeItem(state!.selectedItems.indexOf(item), item);
          } else {
            notifier.addItem(item);
            final index = selectedItems!.length;
            context.read<ListKeyCubit>().addItem(index, item);
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
