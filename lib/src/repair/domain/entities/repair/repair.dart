import 'package:equatable/equatable.dart';
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
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String description;

  final int durationInMinutes;

  final double price;

  final String iconUrl;

  @override
  List<Object?> get props =>
      [id, title, description, durationInMinutes, price, iconUrl];
}
