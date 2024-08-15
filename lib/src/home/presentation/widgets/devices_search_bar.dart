import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DevicesSearchBar extends StatelessWidget {
  const DevicesSearchBar({
    required this.hintText,
    this.onChanged,
    super.key,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
            color: context.colorScheme.onSurface.withOpacity(0.2),
          ),
        ],
        borderRadius: BorderRadius.circular(90.r),
      ),
      child: TextField(
        cursorColor: context.colorScheme.onSurface,
        cursorWidth: 1,
        onChanged: onChanged,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.tertiary,
        ),
        decoration: InputDecoration(
          suffixIcon: CircleAvatar(
            radius: 20.r,
            backgroundColor: context.colorScheme.secondary,
            child: Icon(
              Icons.search_outlined,
              color: context.colorScheme.surface,
            ),
          ),
          suffixIconConstraints: BoxConstraints(minWidth: 55.w),
          hintText: hintText,
          filled: true,
          fillColor: context.colorScheme.surface,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.r),
            borderSide: const BorderSide(style: BorderStyle.none),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.r),
            borderSide: const BorderSide(style: BorderStyle.none),
          ),
        ),
      ),
    );
  }
}
