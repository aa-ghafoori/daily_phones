import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  child: Icon(CupertinoIcons.shopping_cart),
                ),
                CircleAvatar(
                  foregroundColor: context.colorScheme.background,
                  backgroundColor: context.colorScheme.secondary,
                  radius: 10.h,
                  child: Text('0',
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colorScheme.background)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
