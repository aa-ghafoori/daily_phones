import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/core/common/widgets/card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
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

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
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
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: GestureDetector(
              onTap: () => _controller.previousPage(),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.02),
                child: Icon(
                  CupertinoIcons.chevron_left,
                  size: 20.h,
                  color: context.colorScheme.tertiary,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _controller.nextPage(),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.02),
              child: Icon(
                CupertinoIcons.chevron_right,
                size: 20.h,
                color: context.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
      Padding(
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
                children: itemList
                    .asMap()
                    .entries
                    .map((entry) => GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 10.h,
                            height: 10.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.w, horizontal: 4.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  (context.theme.brightness == Brightness.dark
                                          ? context.colorScheme.background
                                          : context.colorScheme.onBackground)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
