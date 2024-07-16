import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

part 'product_color.dart';
part 'product_type.dart';

class Product extends Equatable {
  Product({
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.type,
    required this.colors,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or non empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;

  final String name;

  final Brand brand;

  final String imageUrl;

  final ProductType type;

  final List<ProductColor> colors;

  @override
  List<Object?> get props => [id, name, brand, imageUrl, type];
}
