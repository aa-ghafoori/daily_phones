import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/app/app_bloc_observer.dart';
import 'package:daily_phones/core/common/widgets/custom_snackbar.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/core/res/image_resources.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/views/booking_confirmation_screen.dart';
import 'package:daily_phones/src/repair/presentation/widgets/action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({required this.state, super.key});

  final RepairState state;

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  bool isBusinessSelected = false;

  void _onSelectionChanged(bool isBusiness) {
    setState(() {
      isBusinessSelected = isBusiness;
    });
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = getTotal(widget.state.selectedItems);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SingleSelectionCheckbox(
            onSelectionChanged: _onSelectionChanged,
          ),
          const WhiteSpace(height: 20),
          _FormFields(isBusinessSelected: isBusinessSelected),
          const WhiteSpace(height: 50),
          const _PaymentMethods(),
          const WhiteSpace(height: 30),
          ActionSection(
            totalPrice: totalPrice,
            validateForm: validateForm,
          ),
        ],
      ),
    );
  }
}

class _SingleSelectionCheckbox extends StatefulWidget {
  const _SingleSelectionCheckbox({required this.onSelectionChanged});

  final ValueChanged<bool> onSelectionChanged;

  @override
  _SingleSelectionCheckboxState createState() =>
      _SingleSelectionCheckboxState();
}

class _SingleSelectionCheckboxState extends State<_SingleSelectionCheckbox> {
  bool isFirstSelected = true; // Set Private as selected by default
  bool isSecondSelected = false;

  void _onFirstCheckboxChanged(bool? value) {
    if ((value ?? false) == true && !isFirstSelected) {
      setState(() {
        isFirstSelected = true;
        isSecondSelected = false;
      });
      widget.onSelectionChanged(false);
    }
  }

  void _onSecondCheckboxChanged(bool? value) {
    if ((value ?? false) == true && !isSecondSelected) {
      setState(() {
        isSecondSelected = true;
        isFirstSelected = false;
      });
      widget.onSelectionChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.3.h,
          child: Checkbox.adaptive(
            checkColor: context.colorScheme.secondary,
            side: BorderSide(
              color: context.colorScheme.secondary,
              width: 1.5,
            ),
            value: isFirstSelected,
            onChanged: _onFirstCheckboxChanged,
          ),
        ),
        Text(
          'Private',
          style: context.textTheme.bodyMedium,
        ),
        const WhiteSpace(width: 20),
        Transform.scale(
          scale: 1.3.h,
          child: Checkbox.adaptive(
            checkColor: context.colorScheme.secondary,
            side: BorderSide(
              color: context.colorScheme.secondary,
              width: 1.5,
            ),
            value: isSecondSelected,
            onChanged: _onSecondCheckboxChanged,
          ),
        ),
        Text(
          'Business',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _FormFields extends StatefulWidget {
  const _FormFields({required this.isBusinessSelected});

  final bool isBusinessSelected;

  @override
  State<_FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<_FormFields> {
  bool _shouldDisplayBusinessField = false;

  @override
  void didUpdateWidget(covariant _FormFields oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isBusinessSelected && !_shouldDisplayBusinessField) {
      setState(() {
        _shouldDisplayBusinessField = true;
      });
    } else if (!widget.isBusinessSelected && _shouldDisplayBusinessField) {
      setState(() {
        _shouldDisplayBusinessField = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          onSaved: (value) {
            context.read<RepairBloc>().add(RepairCustomerNameUpdated(value!));
          },
          height: 15.h,
          fieldName: 'NAME',
          keyboardType: TextInputType.name,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const WhiteSpace(height: 30),
        CustomTextFormField(
          onSaved: (value) {
            context.read<RepairBloc>().add(RepairCustomerPhoneUpdated(value!));
          },
          height: 15.h,
          fieldName: 'PHONE',
          keyboardType: TextInputType.phone,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.phoneNumber(),
          ]),
        ),
        const WhiteSpace(height: 30),
        // Business Name field with animation using flutter_animate
        AnimatedSwitcher(
          duration: Durations.medium2,
          switchInCurve: Curves.easeOutQuart,
          switchOutCurve: Curves.easeOutCirc,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: _shouldDisplayBusinessField
              ? Column(
                  key: ValueKey<bool>(_shouldDisplayBusinessField),
                  children: [
                    CustomTextFormField(
                      onSaved: (value) {},
                      height: 15.h,
                      fieldName: 'BUSINESS NAME',
                      keyboardType: TextInputType.streetAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const WhiteSpace(height: 30),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        CustomTextFormField(
          onSaved: (value) {
            context.read<RepairBloc>().add(RepairCustomerEmailUpdated(value!));
          },
          height: 15.h,
          fieldName: 'EMAIL',
          keyboardType: TextInputType.emailAddress,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const WhiteSpace(height: 30),
        CustomTextFormField(
          onSaved: (value) {},
          height: 15.h,
          fieldName: 'NOTES',
          isRequired: false,
        ),
      ],
    );
  }
}

class _PaymentMethods extends StatefulWidget {
  const _PaymentMethods();

  @override
  State<_PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<_PaymentMethods> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Payment Method',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const WhiteSpace(height: 20),
        ItemCard(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Row(
              children: [
                Radio<String>.adaptive(
                  value: 'Pay after repair',
                  fillColor: WidgetStateColor.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? context.colorScheme.secondary
                        : context.colorScheme.tertiary,
                  ),
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    if (value != null) {
                      context
                          .read<RepairBloc>()
                          .add(RepairPaymentMethodSelected(value));
                    }
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                Text(
                  'Pay after repair',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  ImageRes.pay,
                  scale: 1.3 * (1 / 1.h),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ActionSection extends StatefulWidget {
  const ActionSection({
    required this.totalPrice,
    required this.validateForm,
    super.key,
  });

  final double totalPrice;
  final bool Function() validateForm;

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection> {
  bool isChecked = false;

  void _submitForm() {
    if (widget.validateForm()) {
      context.read<RepairBloc>().add(RepairValidationStarted(context));
    } else {
      // Show error if the form is not valid
      CustomSnackbar(
        context: context,
        message: 'Please fill out all required fields!',
        contentType: ContentType.warning,
        title: 'Warning!',
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 1.3.h,
              child: Checkbox.adaptive(
                checkColor: context.colorScheme.secondary,
                side: BorderSide(
                  color: context.colorScheme.secondary,
                  width: 1.5,
                ),
                value: isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'I accept the ',
                style: context.textTheme.labelLarge,
                children: [
                  TextSpan(
                    text: 'terms & conditions.',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: context.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const WhiteSpace(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: RichText(
            text: TextSpan(
              text: 'Total ',
              style: context.textTheme.labelLarge,
              children: [
                TextSpan(
                  text: '€ ${widget.totalPrice}',
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: ' incl. 21% Tax'),
              ],
            ),
          ),
        ),
        const WhiteSpace(height: 20),
        BlocConsumer<RepairBloc, RepairState>(
          listener: (context, state) {
            if (state is RepairValidationCheckSuccess) {
              if (context.read<RepairBloc>().isValidated) {
                if (isChecked) {
                  if (state.customerName != null &&
                      state.customerEmail != null &&
                      state.customerPhone != null) {
                    context.read<RepairBloc>().add(
                          RepairBookingStarted(
                            name: state.customerName!,
                            email: state.customerEmail!,
                            phone: state.customerPhone!,
                          ),
                        );
                  }
                } else {
                  CustomSnackbar(
                    context: context,
                    message: 'Please accept the terms and conditions.',
                    contentType: ContentType.warning,
                    title: 'Warning!',
                  ).show();
                }
              }
            }
            if (state is RepairBookingSuccess) {
              logger.d('before navigation $state');
              context.navigator.pushNamed(
                BookingConfirmationScreen.routeName,
                arguments: state,
              );
            }
            if (state is RepairBookingFailure) {
              CustomSnackbar(
                context: context,
                title: 'Error!',
                message: 'Failed to send email. Please try again.',
                contentType: ContentType.failure,
              ).show();
            }
          },
          builder: (context, state) {
            return state is RepairBookingInProgress
                ? CustomActionButton(
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
                    .shimmer(duration: 500.ms)
                : CustomActionButton(
                    onPressed: _submitForm,
                    backgroundColor: context.colorScheme.secondary,
                    title: 'Confirm Booking',
                    subtitle: 'You can cancel anytime',
                    titleColor: context.colorScheme.surface,
                    subtitleColor: context.colorScheme.surface,
                  );
          },
        ),
      ],
    );
  }
}
