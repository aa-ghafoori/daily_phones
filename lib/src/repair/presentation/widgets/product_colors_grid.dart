import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:flutter/widgets.dart';

class ProductColorsGrid extends StatelessWidget {
  const ProductColorsGrid({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.7,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: product.colors
          .map((productColor) => _ColorCardWidget(productColor: productColor))
          .toList(),
    );
  }
}

class _ColorCardWidget extends StatelessWidget {
  const _ColorCardWidget({required this.productColor});

  final ProductColor productColor;

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
                color: productColor.color.withOpacity(0.8),
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
