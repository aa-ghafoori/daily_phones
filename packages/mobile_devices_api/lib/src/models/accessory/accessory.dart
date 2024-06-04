import 'package:mobile_devices_api/mobile_devices_api.dart';
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
        ),
        id = id ?? Uuid().v4();

  final String id;

  final String title;

  final String description;

  final String imageUrl;

  final double price;

  @override
  List<Object?> get props => [id, title, description, imageUrl, price];

  JsonMap toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory Accessory.fromMap(JsonMap map) {
    return Accessory(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
    );
  }
}
