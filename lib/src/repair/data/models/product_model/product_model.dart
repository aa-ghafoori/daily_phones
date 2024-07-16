import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:flutter/widgets.dart';

part 'product_color_model.dart';
part 'product_type_model.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.brand,
    required super.imageUrl,
    required super.type,
    required super.colors,
    super.id,
  });

  factory ProductModel.fromMap(DataMap map) => ProductModel(
        id: map['id'] as String,
        name: map['name'] as String,
        brand: BrandModel.fromMap(map['brand'] as DataMap),
        imageUrl: map['image_url'] as String,
        type: ProductTypeModel.fromMap(map['type'] as DataMap),
        colors: (map['colors'] as List<dynamic>)
            .map((item) => ProductColorModel.fromMap(item as DataMap))
            .toList(),
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'brand_id': brand.id,
        'type_id': type.id,
        'image_url': imageUrl,
      };

  @override
  List<Object?> get props => [id, name, brand, imageUrl, type];
}
