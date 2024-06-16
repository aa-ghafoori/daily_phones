part of 'repair_model.dart';

class SparePartModel extends SparePart {
  SparePartModel({
    super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.durationInMinutes,
  });

  DataMap toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'durationInMinutes': durationInMinutes,
      };

  factory SparePartModel.fromMapDataMap(DataMap map) => SparePartModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        price: map['price'] as double,
        durationInMinutes: map['durationInMinutes'] as int,
      );

  @override
  List<Object?> get props => [id, title, description, price, durationInMinutes];
}
