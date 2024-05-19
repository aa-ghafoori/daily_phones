import 'package:daily_phones/core/res/extensions.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: _activeStep,
      lineStyle: LineStyle(
        lineType: LineType.normal,
        lineThickness: 8.r,
        lineLength: 60.w,
        defaultLineColor: context.colorScheme.onBackground.withOpacity(0.2),
        progress: 0.5,
        progressColor: context.colorScheme.secondary,
      ),
      internalPadding: 0,
      disableScroll: true,
      showStepBorder: false,
      activeStepTextColor: context.colorScheme.onBackground,
      activeStepBackgroundColor: context.colorScheme.secondary,
      unreachedStepBackgroundColor:
          context.colorScheme.onBackground.withOpacity(0.2),
      unreachedStepTextColor: context.colorScheme.onBackground.withOpacity(0.4),
      showLoadingAnimation: false,
      stepRadius: 20,
      onStepReached: (index) => setState(() => _activeStep = index),
      steps: [
        EasyStep(
            title: 'Apparaten',
            customStep: Text(
              '1',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.background),
            )),
        EasyStep(
            title: 'Reparaties',
            customStep: Text(
              '2',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.background),
            )),
        EasyStep(
            title: 'Afronden',
            customStep: Text(
              '3',
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.background),
            )),
      ],
    );
  }
}
