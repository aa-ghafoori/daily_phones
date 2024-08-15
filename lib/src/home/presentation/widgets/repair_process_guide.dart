// ignore_for_file: lines_longer_than_80_chars

import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairProcessGuide extends StatelessWidget {
  const RepairProcessGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      fit: OverflowBoxFit.deferToChild,
      maxWidth: 1.sw,
      child: Container(
        color: context.colorScheme.secondary,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jouw Reparatie: 3 Eenvoudige Stappen',
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.surface),
            ),
            const RepairStep(
              title: 'Type Selectie',
              description:
                  'Kies het type apparaat dat gerepareerd moet worden.',
            ),
            const RepairStep(
              title: 'Reparatie Keuze',
              description:
                  'Bepaal welke reparatie nodig is voor het geselecteerde item.',
            ),
            const RepairStep(
              title: 'Afspraak Plannen',
              description:
                  'Regel een geschikt moment om de reparatie uit te laten voeren.',
            ),
            const WhiteSpace(height: 20),
            RoundButton(
              text: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Plan Je Afspraak!'),
                  const WhiteSpace(width: 5),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.sp,
                    color: context.colorScheme.surface,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RepairStep extends StatelessWidget {
  const RepairStep({required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WhiteSpace(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Image.asset(ImageRes.check, scale: 6.sp),
            ),
            const WhiteSpace(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: context.colorScheme.surface),
                  ),
                  const WhiteSpace(height: 5),
                  Text(
                    description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.surface),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
