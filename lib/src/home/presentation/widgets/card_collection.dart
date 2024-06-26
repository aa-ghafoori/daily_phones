import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/predefined_data.dart';
import 'package:daily_phones/src/home/presentation/widgets/widgets.dart';
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
        ...cardData.map(
          (data) => CustomCard(
            image: data.image,
            title: data.title,
            description: data.description,
            height: data.height,
          ),
        ),
      ],
    );
  }
}
