part of 'product_model.dart';

class ProductColorModel extends ProductColor {
  ProductColorModel({required super.name, required super.color, super.id});

  factory ProductColorModel.fromEntity(ProductColor color) =>
      ProductColorModel(id: color.id, name: color.name, color: color.color);

  factory ProductColorModel.fromMap(DataMap map) => ProductColorModel(
        id: map['id'] as String,
        name: map['name'] as String,
        color: Color(map['value'] as int),
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'value': color.value,
      };

  @override
  List<Object?> get props => [id, name, color];
}
