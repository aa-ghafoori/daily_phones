import 'package:daily_phones/core/common/widgets/color_card.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/bloc/repair_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class ProductColorsGrid extends StatelessWidget {
  const ProductColorsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colors =
        context.select((RepairBloc bloc) => bloc.state.productColors);
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.7,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: colors
          .map((productColor) => ColorCardWidget(productColor: productColor))
          .toList(),
    );
  }
}

class ColorCardWidget extends StatelessWidget {
  final ProductColor productColor;

  const ColorCardWidget({required this.productColor, super.key});

  @override
  Widget build(BuildContext context) {
    return ColorCard(
      productColor: productColor,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(ProductColor.hexToInteger(productColor.hex))
                    .withOpacity(0.8),
              ),
            ),
            const WhiteSpace(width: 8),
            Text(
              productColor.name.toUpperCase(),
              style: context.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
