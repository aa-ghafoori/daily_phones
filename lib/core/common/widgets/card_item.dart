import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/common/widgets/rectangular_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
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
            horizontal: !isSliderItem ? 30.w : 10.w,
          ),
          child: Column(
            mainAxisAlignment: !isSliderItem
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: !isSliderItem
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              CustomText(
                text: title,
                color: context.colorScheme.background,
                textStyle: !isSliderItem
                    ? context.textTheme.titleSmall
                    : context.textTheme.titleLarge,
              ),
              WhiteSpace(height: !isSliderItem ? 10 : 15),
              CustomText(
                text: description,
                color: context.colorScheme.background,
                textStyle: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const WhiteSpace(height: 10),
              RectangularButton(text: buttonText ?? 'Repareer Nu'),
            ],
          ),
        )
      ],
    );
  }
}
