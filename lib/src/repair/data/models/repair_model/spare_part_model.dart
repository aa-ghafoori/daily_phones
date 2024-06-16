part of 'repair_model.dart';

class SparePartModel extends SparePart {
  SparePartModel({
    required super.title,
    required super.description,
    required super.price,
    required super.durationInMinutes,
    super.id,
  });

  factory SparePartModel.fromMapDataMap(DataMap map) => SparePartModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        price: map['price'] as double,
        durationInMinutes: map['durationInMinutes'] as int,
      );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'durationInMinutes': durationInMinutes,
      };

  @override
  List<Object?> get props => [id, title, description, price, durationInMinutes];
}
