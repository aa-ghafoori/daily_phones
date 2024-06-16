import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Repairs extends StatelessWidget {
  const Repairs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Header(),
        WhiteSpace(height: 10),
        DevicesSearchBar(hintText: 'Zoek je merk, model of modelcode'),
        _DeviceType(image: ImageRes.spDp, text: 'Smartphone'),
        _DeviceType(image: ImageRes.tabletDp, text: 'iPads/Tablet'),
        _DeviceType(image: ImageRes.laptopDp, text: 'Mac/Windows'),
        _DeviceType(image: ImageRes.smartwatchDp1, text: 'Smartwatch'),
        WhiteSpace(height: 70),
        RepairProcessGuide(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Reparaties', style: context.textTheme.titleMedium),
        RoundButton(
          text: Row(
            children: [
              const Text('Alle Reparaties'),
              const WhiteSpace(width: 5),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.sp,
                color: context.colorScheme.background,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeviceType extends StatelessWidget {
  const _DeviceType({required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WhiteSpace(height: 70),
        Image.asset(image),
        const WhiteSpace(height: 20),
        Text(text, style: context.textTheme.titleMedium),
      ],
    );
  }
}
