import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

part 'spare_part_model.dart';

class RepairModel extends Repair {
  RepairModel({
    required super.name,
    required super.description,
    required super.duration,
    required super.price,
    required super.imageUrl,
    super.repairOptions,
    super.id,
  });

  factory RepairModel.fromMap(DataMap map) => RepairModel(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        duration: map['duration'] as int,
        price: map['price'] as double,
        imageUrl: map['image_url'] as String,
      );

  RepairModel copyWith({
    String? name,
    String? description,
    int? duration,
    double? price,
    String? imageUrl,
  }) =>
      RepairModel(
        name: name ?? this.name,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'duration': duration,
        'image_url': imageUrl,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        duration,
        price,
        imageUrl,
        repairOptions,
      ];
}
