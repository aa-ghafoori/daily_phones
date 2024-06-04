import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'product_colors.dart';

enum ProductType { smartphone, laptop, smartwatch, ipadTablet }

class Product extends Equatable {
  Product({
    String? id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.type,
  })  : assert(
            id == null || id.isNotEmpty, 'id must either be null or non empty'),
        id = id ?? const Uuid().v4();

  final String id;

  final String name;

  final String brand;

  final String imageUrl;

  final ProductType type;

  static String productTypeToString(ProductType type) {
    return type.toString().split('.').last;
  }

  static ProductType stringToProductType(String type) {
    return ProductType.values
        .firstWhere((e) => e.toString().split('.').last == type);
  }

  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'type': productTypeToString(type),
    };
  }

  factory Product.fromMap(JsonMap map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      brand: map['brand'] as String,
      imageUrl: map['imageUrl'] as String,
      type: stringToProductType(map['type']),
    );
  }

  static Product get empty => Product(
        name: '',
        brand: '',
        imageUrl: '',
        type: ProductType.smartphone,
      );

  @override
  List<Object?> get props => [id, name, brand, imageUrl, type];
}
