import 'package:daily_phones/core/common/widgets/drawer_item.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                DrawerItem(
                    text: 'Reparaties',
                    onPressed: () {
                      if (ModalRoute.of(context)!.settings.name ==
                          '/select_repair') {
                        context.navigator.removeRoute(ModalRoute.of(context)!);
                      }
                      context.navigator.pop();
                      if (ModalRoute.of(context)!.settings.name != '/repair') {
                        context.navigator.pushNamed('/repair');
                      }
                    }),
                Positioned(
                  top: 22.h,
                  left: 105.w,
                  child: IgnorePointer(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: const Color.fromARGB(255, 194, 49, 23)),
                      child: Text(
                        'KORTING',
                        style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: context.colorScheme.background),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DrawerItem(text: 'Smartphones', hasIcon: true),
            DrawerItem(text: 'iPads/Tablets', hasIcon: true),
            DrawerItem(text: 'Accessories', hasIcon: true),
            DrawerItem(text: 'Screenprotectors', hasIcon: true),
            DrawerItem(text: 'Contact'),
          ],
        ),
      ),
    );
  }
}
