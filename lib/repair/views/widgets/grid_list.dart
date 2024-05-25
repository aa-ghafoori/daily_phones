import 'package:daily_phones/core/common/widgets/description.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridList extends StatelessWidget {
  const GridList({super.key});
  static const List<String> brandImages = [
    ImageRes.apple,
    ImageRes.samsung,
    ImageRes.google,
    ImageRes.oneplus,
    ImageRes.sony,
    ImageRes.xiaomi,
    ImageRes.oppo,
    ImageRes.huawei,
    ImageRes.lg,
    ImageRes.nokia,
    ImageRes.motorola,
    ImageRes.lenovo,
    ImageRes.asus,
    ImageRes.realme,
    ImageRes.blackberry,
    ImageRes.cat,
    ImageRes.alcatel,
    ImageRes.honor,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          const Description(
            text1: 'Of selecteer het',
            text2: 'merk',
          ),
          const WhiteSpace(height: 10),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13.r,
              mainAxisSpacing: 13.r,
              childAspectRatio: 1.5,
            ),
            children: brandImages
                .map(
                  (brandImage) => Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.background,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 0,
                          color:
                              context.colorScheme.onBackground.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      brandImage,
                      scale: 4,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
