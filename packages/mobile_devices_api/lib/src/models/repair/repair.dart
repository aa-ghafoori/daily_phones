import 'package:equatable/equatable.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:uuid/uuid.dart';

part 'spare_part.dart';

class Repair extends Equatable {
  Repair({
    String? id,
    required this.title,
    required this.description,
    required this.durationInMinutes,
    required this.price,
    required this.iconUrl,
  })  : assert(
          id == null || id.isNotEmpty,
        ),
        id = id ?? Uuid().v4();

  final String id;

  final String title;

  final String description;

  final int durationInMinutes;

  final double price;

  final String iconUrl;

  Repair copyWith({
    String? title,
    String? description,
    int? durationInMinutes,
    double? price,
    String? iconUrl,
    List<SparePart>? spareParts,
  }) {
    return Repair(
      title: title ?? this.title,
      description: description ?? this.description,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      price: price ?? this.price,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }

  JsonMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'durationInMinutes': durationInMinutes,
      'price': price,
      'iconUrl': iconUrl,
    };
  }

  factory Repair.fromMap(JsonMap map) {
    return Repair(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      durationInMinutes: map['durationInMinutes'] as int,
      price: map['price'] as double,
      iconUrl: map['iconUrl'] as String,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, durationInMinutes, price, iconUrl];
}
