import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:daily_phones/repair/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCard extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final Item? item;

  const ItemCard(
      {this.isSelected = false, required this.child, this.item, super.key});

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
