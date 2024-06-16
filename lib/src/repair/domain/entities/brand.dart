import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Brand extends Equatable {
  Brand({
    required this.name,
    required this.imageUrl,
    required this.types,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();
  final String id;
  final String name;
  final String imageUrl;
  final List<ProductType> types;

  @override
  List<Object> get props => [id, name, imageUrl, types];
}
