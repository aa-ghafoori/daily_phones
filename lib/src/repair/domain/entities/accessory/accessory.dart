import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Accessory extends Equatable {
  Accessory({
    String? id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String title;

  final String description;

  final String imageUrl;

  final double price;

  @override
  List<Object?> get props => [id, title, description, imageUrl, price];
}
