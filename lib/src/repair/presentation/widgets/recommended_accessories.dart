import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedAccessories extends StatefulWidget {
  const RecommendedAccessories({super.key});

  @override
  State<RecommendedAccessories> createState() => _RecommendedAccessoriesState();
}

class _RecommendedAccessoriesState extends State<RecommendedAccessories> {
  final _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final accessories =
        context.select((RepairBloc bloc) => bloc.state.accessories);
    return Column(
      children: [
        _Header(currentIndex: _current, controller: _controller),
        CarouselSlider(
          carouselController: _controller,
          items: accessories
              .map((accessory) => AccessoryItem(accessory: accessory))
              .toList(),
          options: CarouselOptions(
            initialPage: _current,
            onPageChanged: (index, _) => setState(() => _current = index),
            padEnds: false,
            height: 360,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.currentIndex, required this.controller});

  final int currentIndex;
  final CarouselSliderController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Description(text1: 'Recommended accessories'),
        Row(
          children: [
            _NavigationButton(
              icon: Icons.arrow_back_ios,
              enabled: currentIndex != 0,
              onTap: currentIndex != 0 ? controller.previousPage : null,
            ),
            const WhiteSpace(width: 5),
            _NavigationButton(
              icon: Icons.arrow_forward_ios,
              enabled: currentIndex != 3,
              onTap: currentIndex != 3 ? controller.nextPage : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
          color: enabled
              ? context.colorScheme.secondary
              : context.colorScheme.primary,
        ),
        child: Icon(
          icon,
          size: 13.h,
          color: context.colorScheme.surface,
        ),
      ),
    );
  }
}
