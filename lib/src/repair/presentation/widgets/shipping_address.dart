import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({required this.formKey, super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.focusScope.unfocus,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            const _SectionDivider(),
            const WhiteSpace(height: 20),
            _AddressForm(formKey),
            const WhiteSpace(height: 40),
            _SendingDetails(),
          ],
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.9,
          alignment: Alignment.centerLeft,
          child: const Description(
            text1: 'select',
            text2: 'address',
          ),
        ),
        Expanded(
          child: Divider(
            height: 30.h,
            thickness: 1,
          ),
        ),
        const WhiteSpace(width: 15),
      ],
    );
  }
}

class _AddressForm extends StatelessWidget {
  const _AddressForm(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            fieldName: 'STREET NAME',
            height: 15.h,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const WhiteSpace(height: 30),
          CustomTextFormField(
            fieldName: 'NUMBER',
            height: 15.h,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ],
            ),
          ),
          const WhiteSpace(height: 30),
          CustomTextFormField(
            fieldName: 'ZIP CODE',
            height: 15.h,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.zipCode(),
            ]),
          ),
          const WhiteSpace(height: 30),
          CustomTextFormField(
            fieldName: 'CITY',
            height: 15.h,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _SendingDetails extends StatelessWidget {
  final List<String> repairSteps = [
    'If you are still able to make a backup, it is always advisable to do so.'
        ' In some cases of repair, there may be data loss.',
    'Pack your device as securely as possible and send it to us without accessories with a track-and-trace.',
    'The average inspection time is 1 working day.',
    'We use the repairs you entered as an indication.'
        'We check each device for actual damage and repair costs.',
    'Once the costs are known, we will call you and send a payment link and invoice upon agreement.',
    'After payment of the invoice, we will start the repair.'
        'The average repair time is 2 working days.'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SEND YOUR DEVICE TO',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w300,
          ),
        ),
        const WhiteSpace(height: 20),
        Row(
          children: [
            Flexible(
              child: Text(
                'Daily Phones | Dokkum',
                style: context.textTheme.bodySmall,
              ),
            ),
            WhiteSpace(width: 0.2.sw),
            Flexible(
              child: Text(
                'Waagstraat 14A, 9101 LC Dokkum',
                style: context.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const WhiteSpace(height: 40),
        Text(
          'TERMS SENDING DEVICE',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w300,
          ),
        ),
        const WhiteSpace(height: 20),
        ...repairSteps.asMap().entries.map((entry) {
          final index = entry.key + 1; // Numbering starts from 1
          final step = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$index.  ',
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Text(
                    step,
                    style: context.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
