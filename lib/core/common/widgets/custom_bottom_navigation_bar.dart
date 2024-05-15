import 'package:daily_phones/core/common/widgets/custom_text.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      surfaceTintColor: Colors.transparent,
      child: Center(
        child: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child: FaIcon(FontAwesomeIcons.basketShopping),
                ),
                CircleAvatar(
                  foregroundColor: context.colorScheme.background,
                  backgroundColor: context.colorScheme.secondary,
                  radius: 11.h,
                  child: CustomText(
                    text: Text(
                      '1',
                      style: TextStyle(color: context.colorScheme.background),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
