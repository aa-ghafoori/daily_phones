import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_phones/on_boarding/widgets/card_item.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Widget> itemList = [
  const CardItem(
    isSliderItem: true,
    image: ImageRes.ipadRepair,
    title: 'iPad Reparatie',
    description: 'Repareer je iPad tegen een scherpe prijs!',
  ),
  const CardItem(
    isSliderItem: true,
    image: ImageRes.iphoneRepair,
    title: 'iPhone Reparatie',
    description: 'Repareer je iPhone voor een scherpe prijs',
  ),
  const CardItem(
    isSliderItem: true,
    image: ImageRes.smartWatchRepair,
    title: 'Smartwatch Reparatie',
    description: 'Repareer je smartwatch tegen een scherpe prijs!',
  ),
];

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: itemList,
          options: CarouselOptions(
            height: 0.5.sh,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselControlButton(
              icon: CupertinoIcons.chevron_left,
              onTap: _controller.previousPage,
            ),
            CarouselControlButton(
              icon: CupertinoIcons.chevron_right,
              onTap: _controller.nextPage,
            ),
          ],
        ),
        CarouselIndicator(
          itemCount: itemList.length,
          currentIndex: _current,
          controller: _controller,
        ),
      ],
    );
  }
}

class CarouselControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CarouselControlButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.02),
          child: Icon(
            icon,
            size: 20.h,
            color: context.colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final CarouselController controller;

  const CarouselIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              color: context.colorScheme.background,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                itemCount,
                (index) => GestureDetector(
                  onTap: () => controller.animateToPage(index),
                  child: Container(
                    width: 10.h,
                    height: 10.h,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.w, horizontal: 4.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (context.theme.brightness == Brightness.dark
                              ? context.colorScheme.background
                              : context.colorScheme.onBackground)
                          .withOpacity(currentIndex == index ? 0.9 : 0.4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
