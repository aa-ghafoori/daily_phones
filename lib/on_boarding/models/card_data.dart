import 'package:equatable/equatable.dart';

class CardData extends Equatable {
  final String image;
  final String title;
  final String description;
  final double height;
  final String buttonText;

  const CardData({
    required this.image,
    required this.title,
    required this.description,
    required this.height,
    required this.buttonText,
  });

  @override
  List<Object?> get props => [image, title, description, height, buttonText];
}
