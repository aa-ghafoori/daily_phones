import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem(
      {required this.text,
      this.hasIcon = false,
      VoidCallback? onPressed,
      super.key})
      : onPressed = onPressed ?? (() {});

  final String text;
  final bool hasIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
              shape: MaterialStatePropertyAll(
                  ContinuousRectangleBorder(borderRadius: BorderRadius.zero))),
          onPressed: onPressed,
          icon: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: hasIcon
                ? Row(
                    children: [
                      Text(
                        text,
                        style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const VerticalDivider(thickness: 0),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Icon(
                              CupertinoIcons.chevron_right,
                              size: 17.h,
                              color:
                                  context.colorScheme.tertiary.withOpacity(0.5),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 0,
        )
      ],
    );
  }
}
