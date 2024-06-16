part of 'repair.dart';

class SparePart extends Equatable {
  SparePart({
    String? id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationInMinutes,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final double price;
  final int durationInMinutes;

  @override
  List<Object?> get props => [id, title, description, price, durationInMinutes];
}
