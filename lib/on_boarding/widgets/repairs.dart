import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/on_boarding/widgets/repair_process_guide.dart';
import 'package:daily_phones/on_boarding/widgets/devices_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Repairs extends StatelessWidget {
  const Repairs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        const WhiteSpace(height: 10),
        const DevicesSearchBar(hintText: 'Zoek je merk, model of modelcode'),
        const DeviceType(image: ImageRes.spDp, text: 'Smartphone'),
        const DeviceType(image: ImageRes.tabletDp, text: 'iPads/Tablet'),
        const DeviceType(image: ImageRes.laptopDp, text: 'Mac/Windows'),
        const DeviceType(image: ImageRes.smartwatchDp1, text: 'Smartwatch'),
        const WhiteSpace(height: 70),
        const RepairProcessGuide(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
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

class DeviceType extends StatelessWidget {
  const DeviceType({required this.image, required this.text, super.key});

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
