import 'package:daily_phones/core/res/extensions.dart';
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
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: hasIcon
                ? Row(
                    children: [
                      Text(text),
                      const Spacer(),
                      Row(
                        children: [
                          const VerticalDivider(),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 17.h,
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
                      style: text == 'Reparaties'
                          ? context.textTheme.bodyMedium
                              ?.copyWith(color: context.colorScheme.secondary)
                          : null,
                    ),
                  ),
          ),
        ),
        const Divider(height: 0)
      ],
    );
  }
}
