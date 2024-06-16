import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:daily_phones/src/home/presentation/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      offset: const Offset(0, 4),
      child: AppBar(
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != HomeScreen.routeName) {
              context.navigator.pushNamed(HomeScreen.routeName);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(ImageRes.dpLogo, scale: 5 * 1 / 1.sp),
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
