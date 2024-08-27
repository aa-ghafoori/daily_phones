import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  static const routeName = '/devices';

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.focusScope.unfocus,
      child: CustomScaffold(
        controller: _scrollController,
        body: Container(
          color: context.colorScheme.surface,
          margin: EdgeInsets.only(top: 30.h),
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomStepper(activeStep: 0),
              const WhiteSpace(height: 30),
              const _InfoBar(),
              Stack(
                children: [
                  const Column(
                    children: [
                      WhiteSpace(height: 20),
                      _BackgroundContainer(),
                      CustomGrid(),
                    ],
                  ),
                  Positioned(
                    top: 75.h,
                    left: 0,
                    right: 0,
                    child: DeviceSearch(
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBar extends StatelessWidget {
  const _InfoBar();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RepairBloc>().state;
    return InfoBar(
      onTap: state is RepairLoadSuccess
          ? () {
              if (state.filteredProducts != null) {
                context
                    .read<RepairBloc>()
                    .add(RepairNavigateBackToBrandsPressed());
              } else if (state.brands != null) {
                context
                    .read<RepairBloc>()
                    .add(RepairNavigateBackToTypesPressed());
              } else {
                context.navigator.pop();
              }
            }
          : () {
              if (state.brands != null) {
                context
                    .read<RepairBloc>()
                    .add(RepairNavigateBackToBrandsPressed());
              } else {
                context
                    .read<RepairBloc>()
                    .add(RepairNavigateBackToTypesPressed());
              }
            },
      child: Text.rich(
        TextSpan(
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w300),
          text: 'Welk',
          children: [
            TextSpan(text: ' model ', style: context.textTheme.titleMedium),
            const TextSpan(text: 'heb je?'),
          ],
        ),
      ),
    );
  }
}

class _BackgroundContainer extends StatelessWidget {
  const _BackgroundContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withOpacity(0.05),
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
