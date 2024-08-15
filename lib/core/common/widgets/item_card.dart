import 'package:daily_phones/src/repair/domain/entities/checkout_item.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.child,
    this.isSelected = false,
    this.item,
    super.key,
  });

  final bool isSelected;
  final Widget child;
  final CheckoutItem? item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item != null) {
          if (isSelected) {
            context.read<RepairBloc>().add(RepairItemRemoved(item!));
          } else {
            context.read<RepairBloc>().add(RepairItemAdded(item!));
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
                        .onSurface
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
