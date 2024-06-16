part of 'product.dart';

class ProductColor extends Equatable {
  ProductColor({String? id, required this.name, required this.color})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final Color color;

  @override
  List<Object?> get props => [id, name, color];
}
