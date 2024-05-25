import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.tertiary.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: () {
            context.navigator.pushNamed('/');
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(ImageRes.dpLogo, scale: 5.h),
          ),
        ),
        centerTitle: true,
        actions: [
          const RoundButton(text: Text('Bel Ons')),
          const WhiteSpace(width: 10),
          Builder(
            builder: (context) => GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 15.r),
                child: const Icon(CupertinoIcons.person, size: 30),
              ),
              onTap: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
