import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Accessory extends Equatable {
  Accessory({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String name;

  final String description;

  final String imageUrl;

  final double price;

  @override
  List<Object?> get props => [id, name, description, imageUrl, price];
}
