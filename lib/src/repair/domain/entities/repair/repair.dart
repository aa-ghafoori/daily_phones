import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'spare_part.dart';

class Repair extends Equatable {
  Repair({
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.imageUrl,
    this.repairOptions,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String name;

  final String description;

  final int duration;

  final double price;

  final String imageUrl;

  final List<SparePart>? repairOptions;

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
