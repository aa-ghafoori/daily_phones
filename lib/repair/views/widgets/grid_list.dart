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
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 13,
                color: context.colorScheme.secondary,
              ),
              Text.rich(
                TextSpan(
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                  text: ' Of selecteer het ',
                  children: [
                    TextSpan(
                      text: 'merk',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const WhiteSpace(height: 10),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
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
                          blurRadius: 20,
                          spreadRadius: 5,
                          color: context.colorScheme.onBackground
                              .withOpacity(0.05),
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
