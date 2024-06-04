import 'package:daily_phones/core/common/widgets/custom_scaffold.dart';
import 'package:daily_phones/core/common/widgets/description.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/devices/bloc/devices_bloc.dart';
import 'package:daily_phones/devices/widgets/device_search.dart';
import 'package:daily_phones/core/common/widgets/custom_stepper.dart';
import 'package:daily_phones/devices/widgets/brand_grid.dart';
import 'package:daily_phones/core/common/widgets/info_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicesBloc(
          mobileDevicesRepository: context.read<MobileDevicesRepository>())
        ..add(DevicesStarted()),
      child: const DevicesView(),
    );
  }
}

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<DevicesBloc>().add(DevicesTextFieldOutsideTapped()),
      child: CustomScaffold(
        controller: _scrollController,
        body: Container(
          color: context.colorScheme.background,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomStepper(activeStep: 0),
                  const WhiteSpace(height: 30),
                  InfoBar(title: title(context)),
                  const WhiteSpace(height: 20),
                  const _BackgroundContainer(),
                  const BrandGrid(),
                ],
              ),
              Positioned(
                top: 235.h,
                left: 0,
                right: 0,
                child: DeviceSearch(
                  scrollController: _scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text title(BuildContext context) => Text.rich(
        TextSpan(
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w300),
          text: 'Welk',
          children: [
            TextSpan(text: ' model ', style: context.textTheme.titleMedium),
            const TextSpan(text: 'heb je?')
          ],
        ),
      );
}

class _BackgroundContainer extends StatelessWidget {
  const _BackgroundContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: const Column(
        children: [
          Description(
            text1: 'Voer het',
            text2: 'merk, model',
            text3: 'of',
            text4: 'modelcode',
            text5: 'in',
          ),
          WhiteSpace(height: 70),
        ],
      ),
    );
  }
}
