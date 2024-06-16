import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class AccessoryModel extends Accessory {
  AccessoryModel({
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.price,
    super.id,
  });

  factory AccessoryModel.fromMap(DataMap map) => AccessoryModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        imageUrl: map['imageUrl'] as String,
        price: map['price'] as double,
      );

  DataMap toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
      };

  @override
  List<Object?> get props => [id, title, description, imageUrl, price];
}
