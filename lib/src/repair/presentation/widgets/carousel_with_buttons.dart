import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselWithButtons extends StatefulWidget {
  const CarouselWithButtons({
    required this.items,
    required this.description,
    required this.viewportFraction,
    this.isDateTime = false,
    this.height,
    super.key,
  });

  final List<Widget> items;

  final Widget description;

  final double? height;

  final double viewportFraction;

  final bool isDateTime;

  @override
  State<CarouselWithButtons> createState() => _CarouselWithButtonsState();
}

class _CarouselWithButtonsState extends State<CarouselWithButtons> {
  final _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final itemsPerView = 1 / widget.viewportFraction;
    final lastVisibleIndex = (widget.items.length - itemsPerView).ceil();
    return Column(
      children: [
        _Header(
          currentIndex: _current,
          controller: _controller,
          description: widget.description,
          lastVisibleIndex: lastVisibleIndex,
          isDateTime: widget.isDateTime,
        ),
        CarouselSlider(
          carouselController: _controller,
          items: widget.items,
          options: CarouselOptions(
            initialPage: _current,
            onPageChanged: (index, _) => setState(() => _current = index),
            padEnds: false,
            height: widget.height,
            viewportFraction: widget.viewportFraction,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.currentIndex,
    required this.controller,
    required this.description,
    required this.lastVisibleIndex,
    required this.isDateTime,
  });

  final int currentIndex;
  final CarouselSliderController controller;
  final Widget description;
  final int lastVisibleIndex;
  final bool isDateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: description),
        Row(
          children: [
            _NavigationButton(
              icon: Icons.arrow_back_ios,
              enabled: currentIndex != 0,
              onTap: currentIndex != 0 ? controller.previousPage : null,
              isDateTime: isDateTime,
            ),
            WhiteSpace(width: isDateTime ? 3 : 5),
            _NavigationButton(
              icon: Icons.arrow_forward_ios,
              enabled: currentIndex != lastVisibleIndex,
              onTap:
                  currentIndex != lastVisibleIndex ? controller.nextPage : null,
              isDateTime: isDateTime,
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
    required this.isDateTime,
    this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isDateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: isDateTime ? 0.9 : 1,
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
      ),
    );
  }
}
