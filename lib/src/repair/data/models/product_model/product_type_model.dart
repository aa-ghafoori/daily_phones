part of 'product_model.dart';

class ProductTypeModel extends ProductType {
  ProductTypeModel({required super.name, required super.imageUrl, super.id});

  factory ProductTypeModel.fromMap(DataMap map) => ProductTypeModel(
        id: map['id'] as String,
        name: map['name'] as String,
        imageUrl: map['image_url'] as String,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
      };

  @override
  List<Object?> get props => [id, name, imageUrl];
}
