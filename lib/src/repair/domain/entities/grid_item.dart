import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class GridItem extends Equatable {
  const GridItem({
    required this.name,
    required this.imageUrl,
    required this.ancestor,
  });

  factory GridItem.fromProductType(ProductType type) =>
      GridItem(name: type.name, imageUrl: type.imageUrl, ancestor: type);

  factory GridItem.fromBrand(Brand brand) =>
      GridItem(name: brand.name, imageUrl: brand.imageUrl, ancestor: brand);

  factory GridItem.fromProduct(Product product) => GridItem(
        name: product.name,
        imageUrl: product.imageUrl,
        ancestor: product,
      );

  final String name;

  final String imageUrl;

  final dynamic ancestor;

  @override
  List<Object?> get props => [name, imageUrl, ancestor];
}
