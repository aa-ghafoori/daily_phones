import 'dart:convert';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:flutter/widgets.dart';

part 'product_color_model.dart';

class ProductModel extends Product {
  ProductModel({
    super.id,
    required super.name,
    required super.brand,
    required super.imageUrl,
    required super.type,
    required super.colors,
  });

  static String productTypeToString(ProductType type) =>
      type.toString().split('.').last;

  static ProductType stringToProductType(String type) => ProductType.values
      .firstWhere((e) => e.toString().split('.').last == type);

  DataMap toMap() => {
        'id': id,
        'name': name,
        'brand': brand,
        'imageUrl': imageUrl,
        'type': productTypeToString(type),
        'colors': jsonEncode(colors
            .map((color) => (color as ProductColorModel).toMap())
            .toList()),
      };

  factory ProductModel.fromMap(DataMap map) => ProductModel(
        id: map['id'] as String,
        name: map['name'] as String,
        brand: map['brand'] as String,
        imageUrl: map['imageUrl'] as String,
        type: stringToProductType(map['type'] as String),
        colors: (jsonDecode(map['colors']) as List<dynamic>)
            .map((colorMap) => ProductColorModel.fromMap(colorMap as DataMap))
            .toList(),
      );

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        brand: product.brand,
        imageUrl: product.imageUrl,
        type: product.type,
        colors: product.colors,
      );

  @override
  List<Object?> get props => [id, name, brand, imageUrl, type];
}
