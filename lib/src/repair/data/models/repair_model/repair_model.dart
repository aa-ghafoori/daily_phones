import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

part 'spare_part_model.dart';

class RepairModel extends Repair {
  RepairModel({
    super.id,
    required super.title,
    required super.description,
    required super.durationInMinutes,
    required super.price,
    required super.iconUrl,
  });

  RepairModel copyWith({
    String? title,
    String? description,
    int? durationInMinutes,
    double? price,
    String? iconUrl,
  }) =>
      RepairModel(
        title: title ?? this.title,
        description: description ?? this.description,
        durationInMinutes: durationInMinutes ?? this.durationInMinutes,
        price: price ?? this.price,
        iconUrl: iconUrl ?? this.iconUrl,
      );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'durationInMinutes': durationInMinutes,
        'price': price,
        'iconUrl': iconUrl,
      };

  factory RepairModel.fromMap(DataMap map) => RepairModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        durationInMinutes: map['durationInMinutes'] as int,
        price: map['price'] as double,
        iconUrl: map['iconUrl'] as String,
      );

  @override
  List<Object?> get props =>
      [id, title, description, durationInMinutes, price, iconUrl];
}
