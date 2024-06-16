import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class BrandModel extends Brand {
  BrandModel({
    required super.name,
    required super.imageUrl,
    required super.types,
    super.id,
  });

  factory BrandModel.fromMap(DataMap map) => BrandModel(
        id: map['id'] as String,
        name: map['name'] as String,
        imageUrl: map['imageUrl'] as String,
        types: (map['types'] as String)
            .split(',')
            .map((typeStr) => ProductModel.stringToProductType(typeStr.trim()))
            .toList(),
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'types': types.map(ProductModel.productTypeToString).join(','),
      };

  @override
  List<Object> get props => [id, name, imageUrl, types];
}
