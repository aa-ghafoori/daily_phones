import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

part 'product_color.dart';

enum ProductType { smartphone, laptop, smartwatch, ipadTablet }

class Product extends Equatable {
  Product({
    String? id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.type,
    required this.colors,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String name;

  final String brand;

  final String imageUrl;

  final ProductType type;

  final List<ProductColor> colors;

  factory Product.empty() => Product(
        name: '',
        brand: '',
        imageUrl: '',
        type: ProductType.smartphone,
        colors: const [],
      );

  @override
  List<Object?> get props => [id, name, brand, imageUrl, type];
}
