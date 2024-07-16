part of 'product.dart';

class ProductType extends Equatable {
  ProductType({required this.name, required this.imageUrl, String? id})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, imageUrl];
}
