part of 'repair.dart';

class SparePart extends Equatable {
  SparePart({
    String? id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationInMinutes,
  })  : assert(
            id == null || id.isNotEmpty, 'id must either be null or non empty'),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final double price;
  final int durationInMinutes;

  JsonMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'durationInMinutes': durationInMinutes,
    };
  }

  factory SparePart.fromMap(JsonMap map) {
    return SparePart(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      durationInMinutes: map['durationInMinutes'] as int,
    );
  }

  @override
  List<Object?> get props => [id, title, description, price, durationInMinutes];
}
