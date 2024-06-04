import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/on_boarding/widgets/custom_card.dart';
import 'package:daily_phones/on_boarding/widgets/page_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardCollection extends StatelessWidget {
  const CardCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.5.sh,
          child: const Card(clipBehavior: Clip.hardEdge, child: PageSlider()),
        ),
        const WhiteSpace(height: 12),
        CustomCard(
          image: ImageRes.dpRefurbished,
          title: 'Beste Refurbished',
          description: 'Shop nu onze uitgebreide collectie',
          height: 0.3.sh,
          buttonText: 'Shop Refurbished',
        ),
        const WhiteSpace(height: 12),
        CustomCard(
          image: ImageRes.dpScreen,
          title: 'Screen Protector',
          description: 'Voor de beste bescherming',
          height: 0.2.sh,
          buttonText: 'Vind jouw model',
        ),
        const WhiteSpace(height: 12),
        CustomCard(
          image: ImageRes.screenDp,
          title: 'Hoesjes',
          description: '1000+ designs',
          height: 0.2.sh,
          buttonText: 'Zoek Jouw Design',
        ),
      ],
    );
  }
}
