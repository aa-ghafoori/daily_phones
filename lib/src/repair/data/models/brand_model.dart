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

  factory BrandModel.fromEntity(Brand brand) => BrandModel(
        id: brand.id,
        name: brand.name,
        imageUrl: brand.imageUrl,
        types: brand.types,
      );

  factory BrandModel.fromMap(DataMap map) => BrandModel(
        id: map['id'] as String,
        name: map['name'] as String,
        imageUrl: map['image_url'] as String,
        types: (map['types'] as List<dynamic>)
            .map((item) => ProductTypeModel.fromMap(item as DataMap))
            .toList(),
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
      };

  @override
  List<Object> get props => [id, name, imageUrl, types];
}
