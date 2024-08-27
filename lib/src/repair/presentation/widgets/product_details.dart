import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/domain/entities/product/product.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(product.imageUrl, scale: 16 * (1 / 1.h)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${product.brand.name} ${product.name}',
                style: context.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                product.type.name,
                style: context.textTheme.labelLarge
                    ?.copyWith(color: context.colorScheme.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
