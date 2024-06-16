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
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final accessories =
        context.select((RepairBloc bloc) => bloc.state.accessories);
    return Column(
      children: [
        _buildHeader(context),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Description(text1: 'Recommended accessories'),
        Row(
          children: [
            _buildNavigationButton(
              context,
              icon: Icons.arrow_back_ios,
              enabled: _current != 0,
              onTap: _current != 0 ? _controller.previousPage : null,
            ),
            const WhiteSpace(width: 5),
            _buildNavigationButton(
              context,
              icon: Icons.arrow_forward_ios,
              enabled: _current != 3,
              onTap: _current != 3 ? _controller.nextPage : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationButton(
    BuildContext context, {
    required IconData icon,
    required bool enabled,
    VoidCallback? onTap,
  }) {
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
          color: context.colorScheme.background,
        ),
      ),
    );
  }
}
