import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackbar {
  const CustomSnackbar({
    required this.context,
    required this.message,
    required this.contentType,
    required this.title,
  });

  final BuildContext context;
  final String title;
  final String message;
  final ContentType contentType;

  void show() {
    final snackBar = SnackBar(
      elevation: 0,
      clipBehavior: Clip.none,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        messageFontSize: 14.sp,
        titleFontSize: 20.sp,
        contentType: contentType,
        color: contentType == ContentType.warning
            ? context.colorScheme.onPrimary
            : contentType == ContentType.help
                ? context.colorScheme.secondary
                : null,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
