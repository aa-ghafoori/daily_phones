part of 'product_model.dart';

class ProductColorModel extends ProductColor {
  ProductColorModel({super.id, required super.name, required super.color});

  DataMap toMap() => {
        'id': id,
        'name': name,
        'color': color.value,
      };

  factory ProductColorModel.fromMap(DataMap map) => ProductColorModel(
        id: map['id'] as String,
        name: map['name'] as String,
        color: Color(map['color'] as int),
      );

  @override
  List<Object?> get props => [id, name, color];
}
