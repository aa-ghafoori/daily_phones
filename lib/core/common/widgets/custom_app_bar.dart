import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/on_boarding/views/on_boarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: GestureDetector(
        onTap: () {
          context.navigator.push(MaterialPageRoute(
              builder: (context) => const OnBoardingScreen()));
        },
        child: Image.asset(ImageRes.dpLogo, scale: 5.h),
      ),
      centerTitle: true,
      actions: [
        const RoundButton(text: 'Bel Ons'),
        const WhiteSpace(width: 20),
        Builder(
          builder: (context) => GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 15.h),
              child: const Icon(CupertinoIcons.person, size: 30),
            ),
            onTap: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
