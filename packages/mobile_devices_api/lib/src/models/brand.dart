import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Brand extends Equatable {
  Brand({
    String? id,
    required this.name,
    required this.imageUrl,
    required this.types,
  })  : assert(id == null || id.isNotEmpty,
            'id should be either null or not empty'),
        id = id ?? Uuid().v4();

  final String id;
  final String name;
  final String imageUrl;
  final List<ProductType> types;

  @override
  List<Object> get props => [id, name, imageUrl, types];

  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types.map(Product.productTypeToString).join(','),
    };
  }

  factory Brand.fromMap(JsonMap map) {
    return Brand(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      types: (map['types'] as String)
          .split(',')
          .map((typeStr) => Product.stringToProductType(typeStr.trim()))
          .toList(),
    );
  }
}
