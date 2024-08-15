import 'package:flutter/material.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.isRequired = true,
    this.validator,
    required this.fieldName,
    this.keyboardType,
    this.onSaved,
    super.key,
  });

  final String fieldName;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: context.colorScheme.onSurface,
      cursorWidth: 1,
      style: context.textTheme.bodySmall
          ?.copyWith(color: context.colorScheme.tertiary),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
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
