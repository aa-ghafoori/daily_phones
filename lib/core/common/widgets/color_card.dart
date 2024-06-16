import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCard extends StatelessWidget {
  final Widget child;
  final ProductColor productColor;

  const ColorCard({required this.child, required this.productColor, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        context.select((RepairBloc bloc) => bloc.state.selectedColor) ==
            productColor;

    return GestureDetector(
      onTap: () => context
          .read<RepairBloc>()
          .add(RepairProductColorSelected(productColor: productColor)),
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
