part of 'product.dart';

class ProductColor extends Equatable {
  ProductColor({String? id, required this.name, required this.hex})
      : assert(
            id == null || id.isNotEmpty, 'id must either be null or non empty'),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final String hex;

  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'hex': hex,
    };
  }

  factory ProductColor.fromMap(JsonMap map) {
    return ProductColor(
      id: map['id'] as String,
      name: map['name'] as String,
      hex: map['hex'] as String,
    );
  }

  static int hexToInteger(String hexString) {
    hexString = hexString.replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return (int.parse(hexString, radix: 16));
  }

  @override
  List<Object?> get props => [id, name, hex];
}
