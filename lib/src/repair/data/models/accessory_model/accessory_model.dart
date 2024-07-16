import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class AccessoryModel extends Accessory {
  AccessoryModel({
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    super.id,
  });

  factory AccessoryModel.fromMap(DataMap map) => AccessoryModel(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        imageUrl: map['image_url'] as String,
        price: map['price'] as double,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'image_url': imageUrl,
        'price': price,
      };

  @override
  List<Object?> get props => [id, name, description, imageUrl, price];
}
