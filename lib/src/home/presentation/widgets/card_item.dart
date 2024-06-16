import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    required this.image,
    required this.title,
    required this.description,
    this.isSliderItem = false,
    this.buttonText,
    super.key,
  });

  final String image;
  final String title;
  final String description;
  final bool isSliderItem;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: !isSliderItem ? 5.h : 30.h,
            horizontal: !isSliderItem ? 30.w : 20.w,
          ),
          child: Column(
            mainAxisAlignment: !isSliderItem
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: !isSliderItem
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: !isSliderItem
                    ? context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.background,
                        fontWeight: FontWeight.w600)
                    : context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.background,
                      ),
              ),
              WhiteSpace(height: !isSliderItem ? 10 : 15),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.background,
                ),
              ),
              const WhiteSpace(height: 5),
              RectangularButton(text: Text(buttonText ?? 'Repareer Nu')),
            ],
          ),
        )
      ],
    );
  }
}
