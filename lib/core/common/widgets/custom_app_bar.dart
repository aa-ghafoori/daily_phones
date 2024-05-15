import 'package:daily_phones/core/common/widgets/round_button.dart';
import 'package:daily_phones/core/common/widgets/white_space.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {},
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
              child: const FaIcon(FontAwesomeIcons.user),
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
