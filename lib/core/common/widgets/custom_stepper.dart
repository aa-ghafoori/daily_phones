import 'package:daily_phones/core/common/widgets/easy_stepper/easy_stepper.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({required this.activeStep, super.key});

  final int activeStep;

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: widget.activeStep,
      lineStyle: LineStyle(
        lineType: LineType.normal,
        lineThickness: 8.r,
        lineLength: 60.w,
        defaultLineColor: context.colorScheme.onSurface.withOpacity(0.2),
        finishedLineColor: context.colorScheme.secondary,
        progress: 0.5,
        progressColor: context.colorScheme.secondary,
      ),
      internalPadding: 0,
      defaultStepBorderType: BorderType.normal,
      activeStepBorderColor: context.colorScheme.secondary,
      borderThickness: 5,
      disableScroll: true,
      activeStepTextColor: context.colorScheme.onSurface,
      activeStepBackgroundColor: context.colorScheme.secondary,
      unreachedStepBackgroundColor:
          context.colorScheme.onSurface.withOpacity(0.2),
      unreachedStepTextColor: context.colorScheme.onSurface.withOpacity(0.4),
      unreachedStepBorderColor: Colors.transparent,
      finishedStepBackgroundColor: Colors.transparent,
      finishedStepBorderColor: context.colorScheme.secondary,
      finishedStepTextColor: context.colorScheme.onSurface.withOpacity(0.4),
      finishedStepIconColor: context.colorScheme.secondary,
      showLoadingAnimation: false,
      stepRadius: 20,
      steps: [
        EasyStep(
          icon: const Icon(CupertinoIcons.check_mark),
          title: 'Apparaten',
          customStep: widget.activeStep == 0 ? _buildCustomStepText('1') : null,
        ),
        EasyStep(
          title: 'Reparaties',
          icon: const Icon(CupertinoIcons.check_mark),
          customStep: widget.activeStep <= 1 ? _buildCustomStepText('2') : null,
        ),
        EasyStep(title: 'Afronden', customStep: _buildCustomStepText('3')),
      ],
    );
  }

  Widget _buildCustomStepText(String text) {
    return Text(
      text,
      style: context.textTheme.bodyLarge
          ?.copyWith(color: context.colorScheme.surface),
    );
  }
}
