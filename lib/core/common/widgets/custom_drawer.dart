import 'package:daily_phones/core/common/widgets/drawer_item.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/repair/views/repair_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerItem(
                text: 'Reparaties',
                onPressed: () {
                  context.navigator.pop();
                  context.navigator.push(
                    MaterialPageRoute(builder: (_) => const RepairScreen()),
                  );
                }),
            DrawerItem(text: 'Smartphones', hasIcon: true),
            DrawerItem(text: 'Smartphones', hasIcon: true),
            DrawerItem(text: 'Smartphones', hasIcon: true),
            DrawerItem(text: 'Smartphones', hasIcon: true),
            DrawerItem(text: 'Contact'),
          ],
        ),
      ),
    );
  }
}
