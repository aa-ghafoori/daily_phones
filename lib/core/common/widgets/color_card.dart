import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({required this.child, required this.productColor, super.key});

  final Widget child;
  final ProductColor productColor;

  @override
  Widget build(BuildContext context) {
    final isSelected =
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
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
