import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class BrandModel extends Brand {
  BrandModel({
    super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
  });

  DataMap toMap() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'types': types.map(ProductModel.productTypeToString).join(','),
      };

  factory BrandModel.fromMap(DataMap map) => BrandModel(
        id: map['id'] as String,
        name: map['name'] as String,
        imageUrl: map['imageUrl'] as String,
        types: (map['types'] as String)
            .split(',')
            .map((typeStr) => ProductModel.stringToProductType(typeStr.trim()))
            .toList(),
      );

  @override
  List<Object> get props => [id, name, imageUrl, types];
}
