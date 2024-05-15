import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/on_boarding/views/widgets/repair_steps_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairSteps extends StatelessWidget {
  const RepairSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      fit: OverflowBoxFit.deferToChild,
      maxWidth: 1.sw,
      child: ColoredBox(
        color: context.colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jouw Reparatie: 3 Eenvoudige Stappen',
                style: context.textTheme.titleLarge
                    ?.copyWith(color: context.colorScheme.background),
              ),
              const WhiteSpace(height: 20),
              const RepairStepsItem(
                  title: 'Type Selectie',
                  description:
                      'Kies het type apparaat dat gerepareerd moet worden.'),
              const WhiteSpace(height: 20),
              const RepairStepsItem(
                  title: 'Reparatie Keuze',
                  description:
                      'Bepaal welke reparatie nodig is voor het geselecteerde item.'),
              const WhiteSpace(height: 20),
              const RepairStepsItem(
                  title: 'Afspraak Plannen',
                  description:
                      'Regel een geschikt moment om de reparatie uit te laten voeren.'),
              const WhiteSpace(height: 20),
              RoundButton(
                text: 'Alle Reparaties',
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
