import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    required this.textFieldKey,
    required this.focusNode,
    required this.isFocused,
    required this.handleTextChanged,
    super.key,
  });
  final GlobalKey textFieldKey;
  final FocusNode focusNode;
  final bool isFocused;
  final void Function(String) handleTextChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: isFocused
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                )
              : BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondary.withOpacity(0.2),
              blurStyle: BlurStyle.outer,
              blurRadius: 3,
            ),
          ],
        ),
        child: TextFormField(
          key: textFieldKey,
          focusNode: focusNode,
          onChanged: handleTextChanged,
          cursorColor: context.colorScheme.onSurface,
          cursorWidth: 1,
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'iPhone 12 Pro Max',
            suffixIcon: SearchIcon(isFocused: isFocused, focusNode: focusNode),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: context.colorScheme.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    required this.isFocused,
    required this.focusNode,
    super.key,
  });

  final bool isFocused;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeIn,
      switchInCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        if (child.key == const ValueKey(1)) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        } else {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        }
      },
      child: !isFocused
          ? Container(
              key: const ValueKey<int>(1),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colorScheme.secondary.withOpacity(0.22),
              ),
              child: Icon(
                Icons.search,
                color: context.colorScheme.secondary,
                size: 25,
              ),
            )
          : Padding(
              key: const ValueKey<int>(2),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: focusNode.unfocus,
                child: Icon(
                  CupertinoIcons.xmark_circle_fill,
                  size: 30,
                  color: context.colorScheme.onSurface.withOpacity(0.45),
                ),
              ),
            ),
    );
  }
}
