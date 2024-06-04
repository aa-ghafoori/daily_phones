import 'package:daily_phones/on_boarding/widgets/card_item.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.image,
    required this.title,
    required this.description,
    required this.height,
    this.isSliderItem = false,
    this.buttonText,
    super.key,
  });

  final String image;
  final String title;
  final String description;
  final double height;
  final bool isSliderItem;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: CardItem(
          image: image,
          title: title,
          description: description,
          isSliderItem: isSliderItem,
          buttonText: buttonText,
        ),
      ),
    );
  }
}
