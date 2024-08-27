import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/core/common/widgets/custom_snackbar.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({required this.parentContext, super.key});

  final BuildContext parentContext;

  @override
  State<OfferForm> createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      widget.parentContext.read<RepairBloc>().add(
            RepairOfferFormSubmitted(name: name!, email: email!),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.focusScope.unfocus,
      child: AlertDialog(
        actions: <Widget>[
          BlocConsumer<RepairBloc, RepairState>(
            bloc: widget.parentContext
                .read<RepairBloc>(), // Accessing bloc via widget.parentContext
            listener: (context, state) {
              if (state is RepairOfferEmailSendSuccess) {
                Navigator.of(context).pop(); // Close the dialog
                CustomSnackbar(
                  context: context,
                  message: 'Offer Sent Successfully!',
                  contentType: ContentType.success,
                  title: 'Success!',
                ).show();
              } else if (state is RepairOfferEmailSendFailure) {
                Navigator.of(context).pop(); // Close the dialog
                CustomSnackbar(
                  context: context,
                  message:
                      'Sorry! We could not send the email at the moment, please try again later.',
                  contentType: ContentType.failure,
                  title: 'Oops!',
                ).show();
              }
            },
            builder: (context, state) {
              if (state is RepairOfferEmailSendInProgress) {
                return CustomActionButton(
                  onPressed: () {},
                  backgroundColor: context.colorScheme.secondary,
                  title: '',
                  subtitle: '',
                  titleColor: context.colorScheme.surface,
                  subtitleColor: context.colorScheme.surface,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.surface,
                    strokeWidth: 3,
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 500.ms);
              } else {
                return CustomActionButton(
                  onPressed: _submitForm,
                  backgroundColor: context.colorScheme.secondary,
                  title: 'Send Offer',
                  subtitle: 'Directly in your mailbox',
                  titleColor: context.colorScheme.surface,
                  subtitleColor: context.colorScheme.surface,
                );
              }
            },
          ),
        ],
        content: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SizedBox(
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Receive your offer ',
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w300),
                    children: [
                      TextSpan(
                        text: 'by email',
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Please fill in all necessary information',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            fieldName: 'NAME',
                            keyboardType: TextInputType.name,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            onSaved: (value) => name = value,
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'STREET NAME',
                            keyboardType: TextInputType.streetAddress,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'NUMBER',
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                            ]),
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'ZIP CODE',
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.zipCode(),
                            ]),
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'CITY',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'EMAIL',
                            keyboardType: TextInputType.emailAddress,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                            onSaved: (value) => email = value,
                          ),
                          const WhiteSpace(height: 30),
                          CustomTextFormField(
                            fieldName: 'PHONE',
                            keyboardType: TextInputType.phone,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.phoneNumber(),
                            ]),
                          ),
                          const WhiteSpace(height: 30),
                          const CustomTextFormField(
                            fieldName: 'IMEI NUMBER',
                            keyboardType: TextInputType.number,
                            isRequired: false,
                          ),
                          const WhiteSpace(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
