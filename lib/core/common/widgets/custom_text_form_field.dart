import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.fieldName,
    this.isRequired = true,
    this.validator,
    this.keyboardType,
    this.onSaved,
    this.height,
    super.key,
  });

  final String fieldName;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: fieldName == 'NOTES' ? null : 1,
      minLines: fieldName == 'NOTES' ? 3 : null,
      onSaved: onSaved,
      keyboardType: keyboardType,
      validator: validator,
      cursorWidth: 1,
      style: context.textTheme.bodySmall
          ?.copyWith(color: context.colorScheme.tertiary),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15.w, vertical: height ?? 12.h),
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: fieldName,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isRequired)
                  TextSpan(
                    text: '  *',
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.colorScheme.tertiary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: context.colorScheme.secondary, width: 1.3),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.3, color: context.colorScheme.error),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorStyle: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.error,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
