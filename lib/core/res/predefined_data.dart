// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:daily_phones/core/res/image_resources.dart';
import 'package:daily_phones/src/home/domain/entities/entities.dart';
import 'package:daily_phones/src/home/presentation/widgets/widgets.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

void redPrint(String text) {
  debugPrint('\u001b[1;31m $text');
}

void greenPrint(String text) {
  debugPrint('\u001b[1;32m $text');
}

void yellowPrint(String text) {
  debugPrint('\u001b[1;33m $text');
}

DateTime generateAppointmentDate() {
  final now = DateTime.now();
  final appointmentTime = now.add(const Duration(hours: 24));

  const minHour = 10;
  const maxHour = 17;

  // If the appointment time is outside the allowed range, adjust to the next day at 10:00 AM
  DateTime adjustedAppointmentTime;
  if (appointmentTime.hour < minHour || appointmentTime.hour >= maxHour) {
    adjustedAppointmentTime = DateTime(
      appointmentTime.year,
      appointmentTime.month,
      appointmentTime.day + 1,
      minHour,
    );
  } else {
    adjustedAppointmentTime = appointmentTime;
  }

  // Snap the time to the nearest 30-minute interval
  final minutes = adjustedAppointmentTime.minute;
  final snappedMinutes = (minutes < 30) ? 0 : 30;

  adjustedAppointmentTime = DateTime(
    adjustedAppointmentTime.year,
    adjustedAppointmentTime.month,
    adjustedAppointmentTime.day,
    adjustedAppointmentTime.hour,
    snappedMinutes,
  );

  return adjustedAppointmentTime;
}

List<DateTime> getNext14Days() {
  final dates = <DateTime>[];
  final today = DateTime.now();

  for (var i = 0; i < 14; i++) {
    dates.add(today.add(Duration(days: i)));
  }

  return dates;
}

List<DateItem> generateDateItems(List<DateTime> dates) {
  final dateItems = <DateItem>[];

  // Generate working hours with DateTime objects
  for (final date in dates) {
    final hours = <DateTime>[];
    for (var hour = 10; hour <= 17; hour++) {
      for (var minute = 0; minute < 60; minute += 30) {
        hours.add(DateTime(date.year, date.month, date.day, hour, minute));
      }
    }

    dateItems.add(
      DateItem(
        weekDay:
            DateFormat('EEE').format(date), // Format for abbreviated weekday
        date: DateFormat('dd').format(date), // Format for day of the month
        hours: hours,
      ),
    );
  }

  return dateItems;
}

List<String> generateTimeSlots() {
  final timeSlots = <String>[];
  var startTime = DateTime(2024, 1, 1, 10); // Starting at 10:00 AM
  final endTime = DateTime(2024, 1, 1, 17); // Ending at 5:00 PM

  while (startTime.isBefore(endTime)) {
    final formattedTime = formatTime(startTime);
    timeSlots.add(formattedTime);
    startTime = startTime.add(const Duration(minutes: 30));
  }

  return timeSlots;
}

String formatTime(DateTime time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

// List<DateItem> generateDateItemsForCurrentMonth() {
//   final today = DateTime.now();
//   final totalDaysInMonth = DateTime(today.year, today.month + 1, 0).day;
//   final dateItems = <DateItem>[];
//
//   for (var i = today.day; i <= totalDaysInMonth; i++) {
//     final currentDate = DateTime(today.year, today.month, i);
//     final dayString = i.toString();
//
//     // Weekdays are represented by numbers in DateTime class, so we need to convert them to strings.
//     final weekdays = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     final weekdayString = weekdays[currentDate.weekday -
//         1]; // Subtract 1 because weekday starts from 1 (Monday)
//
//     dateItems.add(DateItem(date: dayString, weekDay: weekdayString));
//   }
//
//   return dateItems;
// }

List<ProductColorModel> generateProductColors(int count) {
  final random = Random();
  final productColors = <ProductColorModel>[];
  final shuffledColors = List<ProductColorModel>.from(predefinedColors)
    ..shuffle(random);

  for (var i = 0; i < count; i++) {
    productColors.add(shuffledColors[i]);
  }

  return productColors;
}

ProductTypeModel getProductTypeByName(String name) {
  return predefinedTypes.firstWhere((type) => type.name == name);
}

BrandModel getBrandByName(String name) {
  return predefinedBrands.firstWhere((brand) => brand.name == name);
}

final List<Widget> pageSliderItemsList = [
  const CardItem(
    isSliderItem: true,
    image: ImageRes.ipadRepair,
    title: 'iPad Reparatie',
    description: 'Repareer je iPad tegen een scherpe prijs!',
  ),
  const CardItem(
    isSliderItem: true,
    image: ImageRes.iphoneRepair,
    title: 'iPhone Reparatie',
    description: 'Repareer je iPhone voor een scherpe prijs',
  ),
  const CardItem(
    isSliderItem: true,
    image: ImageRes.smartWatchRepair,
    title: 'Smartwatch Reparatie',
    description: 'Repareer je smartwatch tegen een scherpe prijs!',
  ),
];

final List<CardData> cardData = [
  CardData(
    image: ImageRes.dpRefurbished,
    title: 'Beste Refurbished',
    description: 'Shop nu onze uitgebreide collectie',
    height: 0.3.sh,
    buttonText: 'Shop Refurbished',
  ),
  CardData(
    image: ImageRes.dpScreen,
    title: 'Screen Protector',
    description: 'Voor de beste bescherming',
    height: 0.2.sh,
    buttonText: 'Vind jouw model',
  ),
  CardData(
    image: ImageRes.screenDp,
    title: 'Hoesjes',
    description: '1000+ designs',
    height: 0.2.sh,
    buttonText: 'Zoek Jouw Design',
  ),
];

final List<String> storeList = [
  'Reparaties',
  'Smartphones',
  'Screenprotector',
  'Accessories',
  'Laptops',
  'iPads/Tablets',
];

final List<String> dailyPhonesList = [
  'Privacybeleid',
  'Algemene Voorwaarden',
  'Garantiebeleid',
  'Retourbeleid',
  'Betaalmethoden',
  'Verzending',
  'klachtenprocedure',
];

final List<String> footerImages = [
  ImageRes.marktplace,
  ImageRes.facebook,
  ImageRes.google2,
  ImageRes.instagram,
];

final List<ProductTypeModel> predefinedTypes = [
  ProductTypeModel(
    name: 'Smartphone',
    imageUrl: ImageRes.smartPhone,
  ),
  ProductTypeModel(
    name: 'Smartwatch',
    imageUrl: ImageRes.smartWatch,
  ),
  ProductTypeModel(
    name: 'iPad/Tablet',
    imageUrl: ImageRes.ipadTablet,
  ),
  ProductTypeModel(
    name: 'Laptop',
    imageUrl: ImageRes.laptop,
  ),
];

final List<BrandModel> predefinedBrands = [
  BrandModel(
    name: 'Apple',
    imageUrl: ImageRes.apple,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
      getProductTypeByName('Smartwatch'),
    ],
  ),
  BrandModel(
    name: 'Samsung',
    imageUrl: ImageRes.samsung,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Smartwatch'),
    ],
  ),
  BrandModel(
    name: 'Google',
    imageUrl: ImageRes.google,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
  BrandModel(
    name: 'OnePlus',
    imageUrl: ImageRes.oneplus,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Sony',
    imageUrl: ImageRes.sony,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
  BrandModel(
    name: 'Xiaomi',
    imageUrl: ImageRes.xiaomi,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Smartwatch'),
    ],
  ),
  BrandModel(
    name: 'Oppo',
    imageUrl: ImageRes.oppo,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Huawei',
    imageUrl: ImageRes.huawei,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
  BrandModel(
    name: 'LG',
    imageUrl: ImageRes.lg,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Smartwatch'),
    ],
  ),
  BrandModel(
    name: 'Nokia',
    imageUrl: ImageRes.nokia,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Motorola',
    imageUrl: ImageRes.motorola,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Lenovo',
    imageUrl: ImageRes.lenovo,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
  BrandModel(
    name: 'Asus',
    imageUrl: ImageRes.asus,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
  BrandModel(
    name: 'Realme',
    imageUrl: ImageRes.realme,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Blackberry',
    imageUrl: ImageRes.blackberry,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Cat',
    imageUrl: ImageRes.cat,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Alcatel',
    imageUrl: ImageRes.alcatel,
    types: [
      getProductTypeByName('Smartphone'),
    ],
  ),
  BrandModel(
    name: 'Honor',
    imageUrl: ImageRes.honor,
    types: [
      getProductTypeByName('Smartphone'),
      getProductTypeByName('Laptop'),
    ],
  ),
];

final List<ProductModel> predefinedProducts = [
  ProductModel(
    name: 'iPhone 14',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 14 Plus',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 14 Pro',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 14 Pro Max',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 13',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 13 mini',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 13 Pro',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 13 Pro Max',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 12',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 12 mini',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 12 Pro',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone 12 Pro Max',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'iPhone SE (2022)',
    brand: getBrandByName('Apple'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S23',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S23+',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S23 Ultra',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S22',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S22+',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S22 Ultra',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy Z Fold 4',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy Z Flip 4',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy A53',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy A73',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Galaxy S21 FE',
    brand: getBrandByName('Samsung'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 7',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 7 Pro',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 6',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 6 Pro',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 5',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 4a',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 5a',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 4',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 4 XL',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 3a',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Pixel 3a XL',
    brand: getBrandByName('Google'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 11',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 10 Pro',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 10T',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 9',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 9 Pro',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 8T',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus Nord 2',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 8',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 8 Pro',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 7T',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'OnePlus 7T Pro',
    brand: getBrandByName('OnePlus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 1 IV',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 5 IV',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 10 IV',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 1 III',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 5 III',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 10 III',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 1 II',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 5 II',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Xperia 10 II',
    brand: getBrandByName('Sony'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 12',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 12 Pro',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Redmi Note 11',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Redmi Note 11 Pro',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 11',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 11 Pro',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 11 Ultra',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 10T',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mi 10T Pro',
    brand: getBrandByName('Xiaomi'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Find X5',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Find X5 Pro',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Reno 8',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Reno 8 Pro',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Reno 7',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Reno 7 Pro',
    brand: getBrandByName('Oppo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mate 50',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mate 50 Pro',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'P50',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'P50 Pro',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'P40',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'P40 Pro',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'P40 Pro+',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mate 40',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mate 40 Pro',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Mate 40 Pro+',
    brand: getBrandByName('Huawei'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Velvet',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Wing',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'G8X ThinQ',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'V60 ThinQ',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Stylo 6',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'K92 5G',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'G8 ThinQ',
    brand: getBrandByName('LG'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '7.2',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '8.3 5G',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '5.4',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '3.4',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'G50',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'G20',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'G10',
    brand: getBrandByName('Nokia'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Edge 30 Pro',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Edge 30 Ultra',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G200',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G100',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G60',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G50',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G30',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G Power (2021)',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Moto G Stylus (2021)',
    brand: getBrandByName('Motorola'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Legion Duel 2',
    brand: getBrandByName('Lenovo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Legion Phone Duel',
    brand: getBrandByName('Lenovo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Legion Y70',
    brand: getBrandByName('Lenovo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Z6 Pro',
    brand: getBrandByName('Lenovo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Z5s',
    brand: getBrandByName('Lenovo'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'ROG Phone 7',
    brand: getBrandByName('Asus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'ROG Phone 6',
    brand: getBrandByName('Asus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'ROG Phone 5',
    brand: getBrandByName('Asus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Zenfone 8',
    brand: getBrandByName('Asus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Zenfone 7',
    brand: getBrandByName('Asus'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Narzo 50',
    brand: getBrandByName('Realme'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Narzo 30',
    brand: getBrandByName('Realme'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Narzo 20',
    brand: getBrandByName('Realme'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Narzo 10',
    brand: getBrandByName('Realme'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Blackberry KEY2',
    brand: getBrandByName('Blackberry'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Blackberry KEYone',
    brand: getBrandByName('Blackberry'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Blackberry Motion',
    brand: getBrandByName('Blackberry'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Blackberry DTEK60',
    brand: getBrandByName('Blackberry'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Cat S62 Pro',
    brand: getBrandByName('Cat'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Cat S52',
    brand: getBrandByName('Cat'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Cat S42',
    brand: getBrandByName('Cat'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Cat S41',
    brand: getBrandByName('Cat'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '1S',
    brand: getBrandByName('Alcatel'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '3L',
    brand: getBrandByName('Alcatel'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '1V',
    brand: getBrandByName('Alcatel'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: '5',
    brand: getBrandByName('Alcatel'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Magic4 Pro',
    brand: getBrandByName('Honor'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Magic4 Lite',
    brand: getBrandByName('Honor'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Magic3',
    brand: getBrandByName('Honor'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
  ProductModel(
    name: 'Magic3 Pro',
    brand: getBrandByName('Honor'),
    imageUrl: ImageRes.iphone15,
    type: getProductTypeByName('Smartphone'),
    colors: generateProductColors(3 + Random().nextInt(4)),
  ),
];

final List<AccessoryModel> predefinedAccessories = [
  AccessoryModel(
    name: 'Screen Protector',
    description: 'Protect your phone screen from scratches and minor impacts.',
    imageUrl: ImageRes.screenProtector,
    price: 15.95,
  ),
  AccessoryModel(
    name: 'Safety Glass',
    description: 'Durable glass protection to prevent screen shattering.',
    imageUrl: ImageRes.safetyGlass,
    price: 25.95,
  ),
  AccessoryModel(
    name: 'Silicon Case',
    description: 'Flexible and lightweight case to protect your phone.',
    imageUrl: ImageRes.siliconCase,
    price: 20.95,
  ),
  AccessoryModel(
    name: 'Phone Book Case',
    description: 'Stylish and functional phone case with additional storage.',
    imageUrl: ImageRes.phoneBookCase,
    price: 30.95,
  ),
];

final List<RepairModel> predefinedRepairs = [
  RepairModel(
    name: 'Screen',
    duration: 30,
    price: 200,
    description:
        "Your screen is cracked, doesn't respond properly, or displays horizontal/vertical lines and/or unusual colors.",
    imageUrl: ImageRes.screen,
  ),
  RepairModel(
    name: 'Battery',
    duration: 20,
    price: 100,
    description:
        'Your battery drains quickly, does not charge fully, or your phone shuts down unexpectedly.',
    imageUrl: ImageRes.charge,
  ),
  RepairModel(
    name: 'Charging Port',
    duration: 45,
    price: 80,
    description:
        'Your charging port is loose, not charging, or requires constant adjusting to work.',
    imageUrl: ImageRes.charge,
  ),
  RepairModel(
    name: 'Camera',
    duration: 60,
    price: 150,
    description:
        'Your camera is blurry, not focusing, or the camera app is not working.',
    imageUrl: ImageRes.camera,
  ),
  RepairModel(
    name: 'Software Update',
    duration: 15,
    price: 30,
    description:
        'Your phone needs the latest software update for better performance and new features.',
    imageUrl: ImageRes.update,
  ),
  RepairModel(
    name: 'Water Damage',
    duration: 120,
    price: 250,
    description:
        'Your phone was exposed to water and needs repair to restore functionality.',
    imageUrl: ImageRes.waterDrop,
  ),
  RepairModel(
    name: 'Vibrator',
    duration: 25,
    price: 50,
    description:
        'Your phone’s vibrator is not working properly or not vibrating at all.',
    imageUrl: ImageRes.vibrator,
  ),
  RepairModel(
    name: 'SIM Card Reader',
    duration: 30,
    price: 60,
    description:
        'Your phone is not detecting the SIM card or frequently loses signal.',
    imageUrl: ImageRes.simcard,
  ),
  RepairModel(
    name: 'Sensor',
    duration: 35,
    price: 70,
    description:
        'Your phone’s sensors (e.g., proximity, accelerometer) are not working correctly.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'WiFi',
    duration: 40,
    price: 80,
    description:
        'Your phone has difficulty connecting to WiFi networks or maintaining a stable connection.',
    imageUrl: ImageRes.wifi,
  ),
  RepairModel(
    name: 'Back Cover',
    duration: 20,
    price: 40,
    description: 'Your phone’s back cover is damaged or needs replacement.',
    imageUrl: ImageRes.backCover,
  ),
  RepairModel(
    name: 'Microphone',
    duration: 45,
    price: 90,
    description:
        'Your phone’s microphone is not working, making it difficult for others to hear you.',
    imageUrl: ImageRes.microphone,
  ),
  RepairModel(
    name: 'Speaker',
    duration: 50,
    price: 100,
    description:
        'Your phone’s speaker is not producing sound or is producing distorted sound.',
    imageUrl: ImageRes.speaker,
  ),
  RepairModel(
    name: 'Button',
    duration: 30,
    price: 50,
    description:
        'A physical button on your phone (e.g., power, volume) is not functioning correctly.',
    imageUrl: ImageRes.button,
  ),
  RepairModel(
    name: 'Display',
    duration: 30,
    price: 220,
    description:
        'Your display has dead pixels, backlight issues, or discoloration.',
    imageUrl: ImageRes.screen,
  ),
  RepairModel(
    name: 'Home Button',
    duration: 25,
    price: 60,
    description: 'The home button is unresponsive or stuck.',
    imageUrl: ImageRes.button,
  ),
  RepairModel(
    name: 'Earpiece Speaker',
    duration: 35,
    price: 70,
    description: 'You can’t hear the other person well during calls.',
    imageUrl: ImageRes.speaker,
  ),
  RepairModel(
    name: 'Proximity Sensor',
    duration: 30,
    price: 50,
    description: 'Your phone screen does not turn off during calls.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Headphone Jack',
    duration: 40,
    price: 80,
    description: 'Your headphone jack is not working or has static noise.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Fingerprint Sensor',
    duration: 30,
    price: 100,
    description: 'The fingerprint sensor is not recognizing fingerprints.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Volume Button',
    duration: 25,
    price: 40,
    description: 'The volume button is stuck or unresponsive.',
    imageUrl: ImageRes.button,
  ),
  RepairModel(
    name: 'Power Button',
    duration: 25,
    price: 40,
    description: 'The power button is stuck or unresponsive.',
    imageUrl: ImageRes.button,
  ),
  RepairModel(
    name: 'Mute Switch',
    duration: 20,
    price: 30,
    description: 'The mute switch is stuck or unresponsive.',
    imageUrl: ImageRes.button,
  ),
  RepairModel(
    name: 'Back Camera Lens',
    duration: 60,
    price: 120,
    description: 'The back camera lens is cracked or scratched.',
    imageUrl: ImageRes.camera,
  ),
  RepairModel(
    name: 'Front Camera',
    duration: 45,
    price: 100,
    description: 'The front camera is blurry or not working.',
    imageUrl: ImageRes.camera,
  ),
  RepairModel(
    name: 'Network Issues',
    duration: 60,
    price: 150,
    description: 'Your phone has trouble connecting to the mobile network.',
    imageUrl: ImageRes.simcard,
  ),
  RepairModel(
    name: 'Bluetooth',
    duration: 30,
    price: 80,
    description: 'Your phone has trouble connecting to Bluetooth devices.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Face ID',
    duration: 50,
    price: 200,
    description: 'Face ID is not working or not recognizing your face.',
    imageUrl: ImageRes.camera,
  ),
  RepairModel(
    name: 'Data Recovery',
    duration: 120,
    price: 300,
    description: 'Recover lost or deleted data from your phone.',
    imageUrl: ImageRes.update,
  ),
  RepairModel(
    name: 'Motherboard',
    duration: 180,
    price: 400,
    description: 'RepairModel or replace a faulty motherboard.',
    imageUrl: ImageRes.investigation,
  ),
  RepairModel(
    name: 'Antenna',
    duration: 45,
    price: 100,
    description: 'Fix issues with weak or no signal.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Loudspeaker',
    duration: 50,
    price: 90,
    description: 'RepairModel or replace a faulty loudspeaker.',
    imageUrl: ImageRes.speaker,
  ),
  RepairModel(
    name: 'MicroSD Slot',
    duration: 35,
    price: 60,
    description: 'The MicroSD slot is not reading cards or is damaged.',
    imageUrl: ImageRes.simcard,
  ),
  RepairModel(
    name: 'GPS',
    duration: 40,
    price: 80,
    description:
        'Your phone has issues with GPS accuracy or not detecting location.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Vibration Motor',
    duration: 25,
    price: 50,
    description: 'Your phone’s vibration motor is weak or not working at all.',
    imageUrl: ImageRes.vibrator,
  ),
  RepairModel(
    name: 'Proximity Sensor Calibration',
    duration: 20,
    price: 30,
    description: 'Calibrate the proximity sensor for accurate detection.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Light Sensor',
    duration: 25,
    price: 50,
    description:
        'The light sensor is not adjusting the screen brightness automatically.',
    imageUrl: ImageRes.sensor,
  ),
  RepairModel(
    name: 'Gyroscope',
    duration: 30,
    price: 70,
    description:
        'The gyroscope is not functioning, affecting screen rotation and gaming.',
    imageUrl: ImageRes.sensor,
  ),
];

final List<ProductColorModel> predefinedColors = [
  ProductColorModel(name: 'Black', color: const Color(0xFF494C50)),
  ProductColorModel(name: 'Red', color: const Color(0xFFC34239)),
  ProductColorModel(name: 'Blue', color: const Color(0xFF6798C9)),
  ProductColorModel(name: 'Green', color: const Color(0xFFD5DDCE)),
  ProductColorModel(name: 'Yellow', color: const Color(0xFFD0BD60)),
  ProductColorModel(name: 'Purple', color: const Color(0xFF9C27B0)),
  ProductColorModel(name: 'Pink', color: const Color(0xFFE8D5D4)),
  ProductColorModel(name: 'Gold', color: const Color(0xFFF8E5BD)),
  ProductColorModel(name: 'Silver', color: const Color(0xFFE3E4DE)),
];
