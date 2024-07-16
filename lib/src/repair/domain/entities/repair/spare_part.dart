part of 'repair.dart';

class SparePart extends Equatable {
  SparePart({
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;

  @override
  List<Object?> get props => [id, name, description, price, duration];
}
