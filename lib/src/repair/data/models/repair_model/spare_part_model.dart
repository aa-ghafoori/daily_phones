part of 'repair_model.dart';

class SparePartModel extends SparePart {
  SparePartModel({
    required super.name,
    required super.description,
    required super.price,
    required super.duration,
    super.id,
  });

  factory SparePartModel.fromEntity(SparePart sparePart) => SparePartModel(
        id: sparePart.id,
        name: sparePart.name,
        description: sparePart.description,
        price: sparePart.price,
        duration: sparePart.duration,
      );

  factory SparePartModel.fromMapDataMap(DataMap map) => SparePartModel(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'] as double,
        duration: map['duration'] as int,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'duration': duration,
      };

  @override
  List<Object?> get props => [id, name, description, price, duration];
}
