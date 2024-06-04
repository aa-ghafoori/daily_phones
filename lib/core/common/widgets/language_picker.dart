import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({super.key});

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  String _selectedItem = 'Nederlands';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: _selectedItem,
        style: context.textTheme.bodySmall,
        iconStyleData: IconStyleData(
          icon: const Icon(CupertinoIcons.chevron_down),
          iconSize: 20.r,
        ),
        selectedItemBuilder: (context) =>
            MenuItems.listItems.map((item) => item.icon).toList(),
        items: MenuItems.listItems
            .map(
              (item) => DropdownMenuItem<String>(
                value: item.text,
                child: MenuItems.buildItem(item),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => _selectedItem = value!),
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(-90, 0),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: List<double>.filled(MenuItems.listItems.length, 48),
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItems {
  static List<MenuItem> listItems = [netherlands, english, deutsch, french];

  static final netherlands = MenuItem(
      text: 'Nederlands', icon: Image.asset(ImageRes.netherlands, scale: 1.5));
  static final english = MenuItem(
      text: 'English (US)', icon: Image.asset(ImageRes.us, scale: 1.5));
  static final deutsch = MenuItem(
      text: 'Deutsch', icon: Image.asset(ImageRes.germany, scale: 1.5));
  static final french = MenuItem(
      text: 'Français', icon: Image.asset(ImageRes.france, scale: 1.5));

  static Widget buildItem(MenuItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        item.icon,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            item.text,
          ),
        ),
      ],
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final Widget icon;
}
