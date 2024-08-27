import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/image_resources.dart';
import 'package:daily_phones/src/repair/domain/entities/delivery_method.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryMethods extends StatefulWidget {
  const DeliveryMethods({required this.controller, super.key});

  final ScrollController controller;

  @override
  State<DeliveryMethods> createState() => _DeliveryMethodsState();
}

class _DeliveryMethodsState extends State<DeliveryMethods> {
  int? _selectedMethodIndex;
  final _formKey = GlobalKey<FormState>();

  void _selectMethod(int index, BuildContext context) {
    final data = index == 0 ? StorePickup() : ShipDevice(formKey: _formKey);
    context.read<RepairBloc>().add(RepairDeliveryMethodSelected(data));
    setState(() {
      _selectedMethodIndex = index;
    });

    // Scroll the selected method to the top
    final box = context.findRenderObject()! as RenderBox;
    final position = box.localToGlobal(Offset.zero).dy +
        widget.controller.offset -
        context.mediaQuery.padding.top -
        30.h -
        kToolbarHeight;

    widget.controller.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Delivery Method',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const WhiteSpace(height: 25),
        _DeliveryMethod(
          index: 0,
          isSelected: _selectedMethodIndex == 0,
          onSelect: (index) => _selectMethod(index, context),
          title: 'Come by our store',
          description: 'Done while you are waiting',
          imageUrl: ImageRes.lock,
          details: const AppointmentPicker(),
        ),
        const WhiteSpace(height: 25),
        _DeliveryMethod(
          index: 1,
          isSelected: _selectedMethodIndex == 1,
          onSelect: (index) => _selectMethod(index, context),
          title: 'Ship device',
          description: 'Repair within 24 hours',
          imageUrl: ImageRes.shipDevice,
          details: ShippingAddress(formKey: _formKey),
        ),
      ],
    );
  }
}

class _DeliveryMethod extends StatelessWidget {
  const _DeliveryMethod({
    required this.index,
    required this.isSelected,
    required this.onSelect,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.details,
  });

  final int index;
  final bool isSelected;
  final void Function(int) onSelect;
  final String imageUrl;
  final String title;
  final String description;
  final Widget details;

  @override
  Widget build(BuildContext context) {
    return ItemCard(
      child: InkWell(
        onTap: () => onSelect(index),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    imageUrl,
                    height: 35.h,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const WhiteSpace(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: title,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(text: ' '),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'FREE',
                                  style: TextStyle(
                                    color: context.colorScheme.secondary,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const WhiteSpace(height: 3),
                      Text(
                        description,
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 1.3.h,
                    child: Checkbox.adaptive(
                      checkColor: context.colorScheme.secondary,
                      side: BorderSide(
                        color: context.colorScheme.secondary,
                        width: 1.5,
                      ),
                      value: isSelected,
                      onChanged: (_) => onSelect(index),
                    ),
                  ),
                ],
              ),
              // Animate the details part with fade in/out
              if (isSelected)
                Column(
                  children: [
                    const WhiteSpace(height: 10),
                    details.animate().fadeIn(
                          duration: 300.ms,
                          curve: Curves.easeInOut,
                        ),
                    const WhiteSpace(height: 30),
                  ],
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
