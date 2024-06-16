import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/presentation/views/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _onPressed(BuildContext context) {
    context.navigator.pop();
    if (ModalRoute.of(context)?.settings.name != DevicesScreen.routeName) {
      context.navigator.pushNamed(DevicesScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                DrawerItem(
                    text: 'Reparaties', onPressed: () => _onPressed(context)),
                Positioned(
                    top: 22.h, left: 105.w, child: _discountBadge(context)),
              ],
            ),
            const DrawerItem(text: 'Smartphones', hasIcon: true),
            const DrawerItem(text: 'iPads/Tablets', hasIcon: true),
            const DrawerItem(text: 'Accessories', hasIcon: true),
            const DrawerItem(text: 'Screenprotectors', hasIcon: true),
            const DrawerItem(text: 'Contact'),
          ],
        ),
      ),
    );
  }

  Widget _discountBadge(BuildContext context) => IgnorePointer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
      );
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    required this.text,
    this.hasIcon = false,
    this.onPressed,
    super.key,
  });

  final String text;
  final bool hasIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
          padding: EdgeInsets.zero,
          onPressed: onPressed ?? () {},
          icon: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  text,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (hasIcon) ...[
                  const Spacer(),
                  Row(
                    children: [
                      const VerticalDivider(thickness: 0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          size: 17.h,
                          color: context.colorScheme.tertiary.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        const Divider(height: 0, thickness: 0),
      ],
    );
  }
}
