import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/carousel_with_buttons.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedAccessories extends StatelessWidget {
  const RecommendedAccessories({super.key});

  @override
  Widget build(BuildContext context) {
    final accessories =
        context.select((RepairBloc bloc) => bloc.state.accessories);

    final items = accessories
        .map((accessory) => AccessoryItem(accessory: accessory))
        .toList();

    return CarouselWithButtons(
      items: items,
      description: const Description(text1: 'Recommended accessories'),
      height: 370.h,
      viewportFraction: 0.75,
    );
  }
}
