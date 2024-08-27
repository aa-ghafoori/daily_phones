import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/core/common/widgets/custom_snackbar.dart';
import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/core/res/predefined_data.dart';

import 'package:daily_phones/src/repair/domain/entities/entities.dart';

import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:daily_phones/src/repair/presentation/widgets/carousel_with_buttons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentPicker extends StatefulWidget {
  const AppointmentPicker({super.key});

  @override
  State<AppointmentPicker> createState() => _AppointmentPickerState();
}

class _AppointmentPickerState extends State<AppointmentPicker> {
  int _selectedAddressIndex = -1; // Track the currently selected address index
  int _selectedDateIndex = -1; // Track the currently selected date index
  final Map<int, int> _selectedTimeIndices = {};
  StorePickup deliveryMethod = StorePickup();

  @override
  Widget build(BuildContext context) {
    final dates = getNext14Days();
    final dateItems = generateDateItems(dates);

    final appointmentDates = dates
        .asMap()
        .entries
        .map(
          (entry) => _DateItem(
            appointmentDate: entry.value,

            isSelected: _selectedDateIndex == entry.key, // Set selection state
            onTap: () => setState(() {
              _selectedDateIndex = entry.key; // Update selected date index
              _selectedTimeIndices.clear();

              context.read<RepairBloc>().add(
                    RepairDeliveryMethodSelected(deliveryMethod, reset: true),
                  );
            }),
          ),
        )
        .toList();

    final appointmentHours = _selectedDateIndex != -1
        ? dateItems[_selectedDateIndex].hours.asMap().entries.map(
            (entry) {
              bool isTimeAvailable;
              _selectedDateIndex == 0 && !isMoreThanTwoHoursAhead(entry.value)
                  ? isTimeAvailable = false
                  : isTimeAvailable = true;

              return _DateItem(
                appointmentDate: entry.value,
                isTime: true,
                isSelected:
                    _selectedTimeIndices[_selectedDateIndex] == entry.key,
                isAvailable: isTimeAvailable,
                onTap: isTimeAvailable
                    ? () {
                        deliveryMethod = deliveryMethod.copyWith(
                          appointmentDate: entry.value,
                        );

                        context.read<RepairBloc>().add(
                              RepairDeliveryMethodSelected(deliveryMethod),
                            );
                        setState(
                          () => _selectedTimeIndices[_selectedDateIndex] =
                              entry.key,
                        );
                      }
                    : () => CustomSnackbar(
                          context: context,
                          message: 'Please select a further date or time.',
                          contentType: ContentType.help,
                          title: 'Info!',
                        ).show(),
              );
            },
          ).toList()
        : null;

    final addressCards = [
      _AddressCard(
        address: '9101 LC Dokkum',
        street: 'Waagstraat 14A',
        title: 'Daily Phones | Dokkum',
        isSelected: _selectedAddressIndex == 0,
        onTap: () {
          deliveryMethod =
              deliveryMethod.copyWith(address: 'Daily Phones | Dokkum');

          context
              .read<RepairBloc>()
              .add(RepairDeliveryMethodSelected(deliveryMethod));
          setState(() {
            _selectedAddressIndex = 0; // Update selected address index
          });
        },
      ),
      const WhiteSpace(height: 20),
      _AddressCard(
        address: '8861 BC Harlingen',
        street: 'Voorstraat 15',
        title: 'Daily Phones | Harlingen',
        isSelected: _selectedAddressIndex == 1,
        onTap: () {
          deliveryMethod =
              deliveryMethod.copyWith(address: 'Daily Phones | Harlingen');
          context
              .read<RepairBloc>()
              .add(RepairDeliveryMethodSelected(deliveryMethod));
          setState(() {
            _selectedAddressIndex = 1; // Update selected address index
          });
        },
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          const _SectionDivider(title: 'location'),
          const WhiteSpace(height: 10),
          ...addressCards,
          const WhiteSpace(height: 30),
          CarouselWithButtons(
            items: appointmentDates,
            description: const _SectionDivider(title: 'date'),
            height: 70.h,
            viewportFraction: 0.2,
            isDateTime: true,
          ),
          const WhiteSpace(height: 30),
          if (_selectedDateIndex != -1)
            CarouselWithButtons(
              items: appointmentHours!,
              description: const _SectionDivider(title: 'time'),
              height: 35.h,
              viewportFraction: 0.25,
              isDateTime: true,
            ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.9,
          alignment: Alignment.centerLeft,
          child: Description(
            text1: 'select',
            text2: title,
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

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.title,
    required this.street,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String street;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ItemCard(
      onTap: onTap,
      isSelected: isSelected,
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              street,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              address,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem({
    required this.onTap,
    required this.appointmentDate,
    this.isSelected = false,
    this.isAvailable = true,
    this.isTime = false,
  });

  final DateTime appointmentDate;
  final bool isSelected;
  final bool isAvailable;
  final bool isTime;
  final VoidCallback? onTap;

  DateItem createDateItem(DateTime dateTime) {
    // Get the weekday (first three letters)
    final weekDay = DateFormat('EEE').format(dateTime);

    // Get the day of the month
    final date = DateFormat('d').format(dateTime);

    // Generate working hours from 10:00 to 17:00 in 30-minute intervals
    final hours = <DateTime>[];
    var startTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 10);
    final endTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 17);

    while (startTime.isBefore(endTime)) {
      hours.add(startTime);
      startTime = startTime.add(const Duration(minutes: 30));
    }

    // Extract the time from the provided DateTime
    final time = DateFormat('HH:mm').format(dateTime);

    return DateItem(
      weekDay: weekDay,
      date: date,
      hours: hours,
      time: time, // Assign the time from the provided DateTime
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateItem = createDateItem(appointmentDate);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Durations.short2,
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.secondary
                : context.colorScheme.tertiary.withOpacity(0.5),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: isTime ? 10.w : 5.w,
          ),
          child: WhiteSpace(
            width: isTime ? 45.w : 35.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isTime)
                  Text(
                    dateItem.weekDay,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: !isAvailable
                          ? context.colorScheme.onSurface.withOpacity(0.5)
                          : null,
                    ),
                  ),
                if (!isTime) const WhiteSpace(height: 5),
                Text(
                  isTime ? dateItem.time! : dateItem.date,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: !isAvailable
                        ? context.colorScheme.onSurface.withOpacity(0.5)
                        : null,
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
