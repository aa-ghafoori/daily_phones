import 'package:daily_phones/core/common/widgets/custom_box_shadow.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      offset: const Offset(0, -4),
      child: BottomAppBar(
        padding: EdgeInsets.zero,
        height: 70,
        surfaceTintColor: Colors.transparent,
        child: Center(
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, right: 15),
                        child: Icon(CupertinoIcons.shopping_cart),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 10,
                        child: CircleAvatar(
                          foregroundColor: context.colorScheme.background,
                          backgroundColor: context.colorScheme.secondary,
                          radius: 8,
                          child: Text(
                            '0',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.background,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Cart',
                    style: context.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
