import 'dart:math';

import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/material.dart';

class Repair {
  final String title;
  final String duration;
  final String price;
  final String description;
  final String image;

  Repair({
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.image,
  });
}

List<Repair> repairsList = [
  Repair(
    title: 'Screen',
    duration: '30',
    price: '200',
    description:
        "Your screen is cracked, doesn't respond properly, or displays horizontal/vertical lines and/or unusual colors.",
    image: ImageRes.screen,
  ),
  Repair(
    title: 'Battery',
    duration: '20',
    price: '100',
    description:
        'Your battery drains quickly, does not charge fully, or your phone shuts down unexpectedly.',
    image: ImageRes.charge,
  ),
  Repair(
    title: 'Charging Port',
    duration: '45',
    price: '80',
    description:
        'Your charging port is loose, not charging, or requires constant adjusting to work.',
    image: ImageRes.charge,
  ),
  Repair(
    title: 'Camera',
    duration: '60',
    price: '150',
    description:
        'Your camera is blurry, not focusing, or the camera app is not working.',
    image: ImageRes.camera,
  ),
  Repair(
    title: 'Software Update',
    duration: '15',
    price: '30',
    description:
        'Your phone needs the latest software update for better performance and new features.',
    image: ImageRes.update,
  ),
  Repair(
    title: 'Water Damage',
    duration: '120',
    price: '250',
    description:
        'Your phone was exposed to water and needs repair to restore functionality.',
    image: ImageRes.waterDrop,
  ),
  Repair(
    title: 'Vibrator',
    duration: '25',
    price: '50',
    description:
        'Your phone’s vibrator is not working properly or not vibrating at all.',
    image: ImageRes.vibrator,
  ),
  Repair(
    title: 'SIM Card Reader',
    duration: '30',
    price: '60',
    description:
        'Your phone is not detecting the SIM card or frequently loses signal.',
    image: ImageRes.simcard,
  ),
  Repair(
    title: 'Sensor',
    duration: '35',
    price: '70',
    description:
        'Your phone’s sensors (e.g., proximity, accelerometer) are not working correctly.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'WiFi',
    duration: '40',
    price: '80',
    description:
        'Your phone has difficulty connecting to WiFi networks or maintaining a stable connection.',
    image: ImageRes.wifi,
  ),
  Repair(
    title: 'Back Cover',
    duration: '20',
    price: '40',
    description: 'Your phone’s back cover is damaged or needs replacement.',
    image: ImageRes.backCover,
  ),
  Repair(
    title: 'Microphone',
    duration: '45',
    price: '90',
    description:
        'Your phone’s microphone is not working, making it difficult for others to hear you.',
    image: ImageRes.microphone,
  ),
  Repair(
    title: 'Speaker',
    duration: '50',
    price: '100',
    description:
        'Your phone’s speaker is not producing sound or is producing distorted sound.',
    image: ImageRes.speaker,
  ),
  Repair(
    title: 'Button',
    duration: '30',
    price: '50',
    description:
        'A physical button on your phone (e.g., power, volume) is not functioning correctly.',
    image: ImageRes.button,
  ),
  // Additional Repair items
  Repair(
    title: 'Display',
    duration: '30',
    price: '220',
    description:
        'Your display has dead pixels, backlight issues, or discoloration.',
    image: ImageRes.screen,
  ),
  Repair(
    title: 'Home Button',
    duration: '25',
    price: '60',
    description: 'The home button is unresponsive or stuck.',
    image: ImageRes.button,
  ),
  Repair(
    title: 'Earpiece Speaker',
    duration: '35',
    price: '70',
    description: 'You can’t hear the other person well during calls.',
    image: ImageRes.speaker,
  ),
  Repair(
    title: 'Proximity Sensor',
    duration: '30',
    price: '50',
    description: 'Your phone screen does not turn off during calls.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Headphone Jack',
    duration: '40',
    price: '80',
    description: 'Your headphone jack is not working or has static noise.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Fingerprint Sensor',
    duration: '30',
    price: '100',
    description: 'The fingerprint sensor is not recognizing fingerprints.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Volume Button',
    duration: '25',
    price: '40',
    description: 'The volume button is stuck or unresponsive.',
    image: ImageRes.button,
  ),
  Repair(
    title: 'Power Button',
    duration: '25',
    price: '40',
    description: 'The power button is stuck or unresponsive.',
    image: ImageRes.button,
  ),
  Repair(
    title: 'Mute Switch',
    duration: '20',
    price: '30',
    description: 'The mute switch is stuck or unresponsive.',
    image: ImageRes.button,
  ),
  Repair(
    title: 'Back Camera Lens',
    duration: '60',
    price: '120',
    description: 'The back camera lens is cracked or scratched.',
    image: ImageRes.camera,
  ),
  Repair(
    title: 'Front Camera',
    duration: '45',
    price: '100',
    description: 'The front camera is blurry or not working.',
    image: ImageRes.camera,
  ),
  Repair(
    title: 'Network Issues',
    duration: '60',
    price: '150',
    description: 'Your phone has trouble connecting to the mobile network.',
    image: ImageRes.simcard,
  ),
  Repair(
    title: 'Bluetooth',
    duration: '30',
    price: '80',
    description: 'Your phone has trouble connecting to Bluetooth devices.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Face ID',
    duration: '50',
    price: '200',
    description: 'Face ID is not working or not recognizing your face.',
    image: ImageRes.camera,
  ),
  Repair(
    title: 'Data Recovery',
    duration: '120',
    price: '300',
    description: 'Recover lost or deleted data from your phone.',
    image: ImageRes.update,
  ),
  Repair(
    title: 'Motherboard',
    duration: '180',
    price: '400',
    description: 'Repair or replace a faulty motherboard.',
    image: ImageRes.investigation,
  ),
  Repair(
    title: 'Antenna',
    duration: '45',
    price: '100',
    description: 'Fix issues with weak or no signal.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Loudspeaker',
    duration: '50',
    price: '90',
    description: 'Repair or replace a faulty loudspeaker.',
    image: ImageRes.speaker,
  ),
  Repair(
    title: 'MicroSD Slot',
    duration: '35',
    price: '60',
    description: 'The MicroSD slot is not reading cards or is damaged.',
    image: ImageRes.simcard,
  ),
  Repair(
    title: 'GPS',
    duration: '40',
    price: '80',
    description:
        'Your phone has issues with GPS accuracy or not detecting location.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Vibration Motor',
    duration: '25',
    price: '50',
    description: 'Your phone’s vibration motor is weak or not working at all.',
    image: ImageRes.vibrator,
  ),
  Repair(
    title: 'Proximity Sensor Calibration',
    duration: '20',
    price: '30',
    description: 'Calibrate the proximity sensor for accurate detection.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Light Sensor',
    duration: '25',
    price: '50',
    description:
        'The light sensor is not adjusting the screen brightness automatically.',
    image: ImageRes.sensor,
  ),
  Repair(
    title: 'Gyroscope',
    duration: '30',
    price: '70',
    description:
        'The gyroscope is not functioning, affecting screen rotation and gaming.',
    image: ImageRes.sensor,
  ),
];

class SmartphoneBrand {
  final String brand;
  final List<Product> products;
  final String image;

  SmartphoneBrand({
    required this.brand,
    required this.products,
    required this.image,
  });
}

class Product {
  final String name;
  final List<SmartphoneColor> colors;
  final String? brand;

  Product({
    required this.name,
    required this.colors,
    this.brand,
  });

  static Product get empty => Product(name: 'name', colors: [], brand: '');
}

class SmartphoneColor {
  final String name;
  final Color color;

  SmartphoneColor({
    required this.name,
    required this.color,
  });
}

class ColorMap {
  ColorMap._();
  static const Color black = Color.fromARGB(255, 73, 76, 80);
  static const Color white = Colors.white;
  static const Color red = Color.fromARGB(255, 195, 66, 57);
  static const Color blue = Color.fromARGB(255, 103, 152, 201);
  static const Color green = Color.fromARGB(255, 213, 221, 206);
  static const Color yellow = Color.fromARGB(255, 208, 189, 96);
  static const Color purple = Colors.purple;
  static const Color pink = Color.fromARGB(255, 232, 213, 212);
  static const Color gold = Color.fromARGB(255, 248, 229, 189);
  static const Color silver = Color.fromARGB(255, 227, 228, 222);
}

List<SmartphoneColor> availableColors = [
  SmartphoneColor(name: 'Black', color: ColorMap.black),
  SmartphoneColor(name: 'Red', color: ColorMap.red),
  SmartphoneColor(name: 'Blue', color: ColorMap.blue),
  SmartphoneColor(name: 'Green', color: ColorMap.green),
  SmartphoneColor(name: 'Yellow', color: ColorMap.yellow),
  SmartphoneColor(name: 'Purple', color: ColorMap.purple),
  SmartphoneColor(name: 'Pink', color: ColorMap.pink),
  SmartphoneColor(name: 'Gold', color: ColorMap.gold),
  SmartphoneColor(name: 'Silver', color: ColorMap.silver),
];

List<SmartphoneColor> getRandomColors() {
  final random = Random();
  int count = random.nextInt(5) + 2;

  if (count > availableColors.length) {
    count = availableColors.length;
  }

  List<SmartphoneColor> selectedColors = [];
  List<SmartphoneColor> colorsPool = List.from(availableColors);

  for (int i = 0; i < count; i++) {
    int index = random.nextInt(colorsPool.length);
    selectedColors.add(colorsPool.removeAt(index));
  }

  return selectedColors;
}

List<SmartphoneBrand> smartphoneBrands = [
  SmartphoneBrand(
    brand: 'Apple',
    products: [
      Product(name: 'iPhone 14', colors: getRandomColors()),
      Product(name: 'iPhone 14 Plus', colors: getRandomColors()),
      Product(name: 'iPhone 14 Pro', colors: getRandomColors()),
      Product(name: 'iPhone 14 Pro Max', colors: getRandomColors()),
      Product(name: 'iPhone 13', colors: getRandomColors()),
      Product(name: 'iPhone 13 mini', colors: getRandomColors()),
      Product(name: 'iPhone 13 Pro', colors: getRandomColors()),
      Product(name: 'iPhone 13 Pro Max', colors: getRandomColors()),
      Product(name: 'iPhone 12', colors: getRandomColors()),
      Product(name: 'iPhone 12 mini', colors: getRandomColors()),
      Product(name: 'iPhone 12 Pro', colors: getRandomColors()),
      Product(name: 'iPhone 12 Pro Max', colors: getRandomColors()),
      Product(name: 'iPhone SE (2022)', colors: getRandomColors()),
    ],
    image: ImageRes.apple,
  ),
  SmartphoneBrand(
    brand: 'Samsung',
    products: [
      Product(name: 'Galaxy S23', colors: getRandomColors()),
      Product(name: 'Galaxy S23+', colors: getRandomColors()),
      Product(name: 'Galaxy S23 Ultra', colors: getRandomColors()),
      Product(name: 'Galaxy S22', colors: getRandomColors()),
      Product(name: 'Galaxy S22+', colors: getRandomColors()),
      Product(name: 'Galaxy S22 Ultra', colors: getRandomColors()),
      Product(name: 'Galaxy Z Fold 4', colors: getRandomColors()),
      Product(name: 'Galaxy Z Flip 4', colors: getRandomColors()),
      Product(name: 'Galaxy A53', colors: getRandomColors()),
      Product(name: 'Galaxy A73', colors: getRandomColors()),
      Product(name: 'Galaxy S21 FE', colors: getRandomColors()),
    ],
    image: ImageRes.samsung,
  ),
  SmartphoneBrand(
    brand: 'Google',
    products: [
      Product(name: 'Pixel 7', colors: getRandomColors()),
      Product(name: 'Pixel 7 Pro', colors: getRandomColors()),
      Product(name: 'Pixel 6', colors: getRandomColors()),
      Product(name: 'Pixel 6 Pro', colors: getRandomColors()),
      Product(name: 'Pixel 5', colors: getRandomColors()),
      Product(name: 'Pixel 4a', colors: getRandomColors()),
      Product(name: 'Pixel 5a', colors: getRandomColors()),
      Product(name: 'Pixel 4', colors: getRandomColors()),
      Product(name: 'Pixel 4 XL', colors: getRandomColors()),
      Product(name: 'Pixel 3a', colors: getRandomColors()),
      Product(name: 'Pixel 3a XL', colors: getRandomColors()),
    ],
    image: ImageRes.google,
  ),
  SmartphoneBrand(
    brand: 'OnePlus',
    products: [
      Product(name: 'OnePlus 11', colors: getRandomColors()),
      Product(name: 'OnePlus 10 Pro', colors: getRandomColors()),
      Product(name: 'OnePlus 10T', colors: getRandomColors()),
      Product(name: 'OnePlus 9', colors: getRandomColors()),
      Product(name: 'OnePlus 9 Pro', colors: getRandomColors()),
      Product(name: 'OnePlus 8T', colors: getRandomColors()),
      Product(name: 'OnePlus Nord 2', colors: getRandomColors()),
      Product(name: 'OnePlus 8', colors: getRandomColors()),
      Product(name: 'OnePlus 8 Pro', colors: getRandomColors()),
      Product(name: 'OnePlus 7T', colors: getRandomColors()),
      Product(name: 'OnePlus 7T Pro', colors: getRandomColors()),
    ],
    image: ImageRes.oneplus,
  ),
  SmartphoneBrand(
    brand: 'Sony',
    products: [
      Product(name: 'Xperia 1 IV', colors: getRandomColors()),
      Product(name: 'Xperia 5 IV', colors: getRandomColors()),
      Product(name: 'Xperia 10 IV', colors: getRandomColors()),
      Product(name: 'Xperia 1 III', colors: getRandomColors()),
      Product(name: 'Xperia 5 III', colors: getRandomColors()),
      Product(name: 'Xperia Pro-I', colors: getRandomColors()),
      Product(name: 'Xperia 10 III', colors: getRandomColors()),
      Product(name: 'Xperia 1 II', colors: getRandomColors()),
      Product(name: 'Xperia 5 II', colors: getRandomColors()),
      Product(name: 'Xperia 10 II', colors: getRandomColors()),
      Product(name: 'Xperia L4', colors: getRandomColors()),
    ],
    image: ImageRes.sony,
  ),
  SmartphoneBrand(
    brand: 'Xiaomi',
    products: [
      Product(name: 'Mi 12', colors: getRandomColors()),
      Product(name: 'Mi 12 Pro', colors: getRandomColors()),
      Product(name: 'Mi 11', colors: getRandomColors()),
      Product(name: 'Mi 11 Ultra', colors: getRandomColors()),
      Product(name: 'Mi 11i', colors: getRandomColors()),
      Product(name: 'Mi 10T', colors: getRandomColors()),
      Product(name: 'Mi 10', colors: getRandomColors()),
      Product(name: 'Mi 10 Pro', colors: getRandomColors()),
      Product(name: 'Redmi Note 11', colors: getRandomColors()),
      Product(name: 'Redmi Note 10', colors: getRandomColors()),
      Product(name: 'Redmi 9T', colors: getRandomColors()),
    ],
    image: ImageRes.xiaomi,
  ),
  SmartphoneBrand(
    brand: 'Oppo',
    products: [
      Product(name: 'Find X5', colors: getRandomColors()),
      Product(name: 'Find X5 Pro', colors: getRandomColors()),
      Product(name: 'Find X3 Pro', colors: getRandomColors()),
      Product(name: 'Find X2 Pro', colors: getRandomColors()),
      Product(name: 'Reno6 Pro', colors: getRandomColors()),
      Product(name: 'Reno5 Pro', colors: getRandomColors()),
      Product(name: 'Reno8 Pro', colors: getRandomColors()),
      Product(name: 'Reno7', colors: getRandomColors()),
      Product(name: 'Reno6', colors: getRandomColors()),
      Product(name: 'A95', colors: getRandomColors()),
      Product(name: 'A74', colors: getRandomColors()),
    ],
    image: ImageRes.oppo,
  ),
  SmartphoneBrand(
    brand: 'Huawei',
    products: [
      Product(name: 'P50 Pro', colors: getRandomColors()),
      Product(name: 'P50', colors: getRandomColors()),
      Product(name: 'Mate 40 Pro', colors: getRandomColors()),
      Product(name: 'Mate 40', colors: getRandomColors()),
      Product(name: 'P40 Pro', colors: getRandomColors()),
      Product(name: 'P40', colors: getRandomColors()),
      Product(name: 'P30 Pro', colors: getRandomColors()),
      Product(name: 'P30', colors: getRandomColors()),
      Product(name: 'Mate 30 Pro', colors: getRandomColors()),
      Product(name: 'Mate 30', colors: getRandomColors()),
    ],
    image: ImageRes.huawei,
  ),
  SmartphoneBrand(
    brand: 'LG',
    products: [
      Product(name: 'Velvet', colors: getRandomColors()),
      Product(name: 'Wing', colors: getRandomColors()),
      Product(name: 'V60 ThinQ', colors: getRandomColors()),
      Product(name: 'G8X ThinQ', colors: getRandomColors()),
      Product(name: 'V50 ThinQ', colors: getRandomColors()),
      Product(name: 'G8 ThinQ', colors: getRandomColors()),
      Product(name: 'V40 ThinQ', colors: getRandomColors()),
      Product(name: 'G7 ThinQ', colors: getRandomColors()),
      Product(name: 'Q70', colors: getRandomColors()),
      Product(name: 'K92', colors: getRandomColors()),
    ],
    image: ImageRes.lg,
  ),
  SmartphoneBrand(
    brand: 'Nokia',
    products: [
      Product(name: 'G50', colors: getRandomColors()),
      Product(name: 'X20', colors: getRandomColors()),
      Product(name: 'X10', colors: getRandomColors()),
      Product(name: '8.3 5G', colors: getRandomColors()),
      Product(name: '5.4', colors: getRandomColors()),
      Product(name: '3.4', colors: getRandomColors()),
      Product(name: 'C3', colors: getRandomColors()),
      Product(name: '2.4', colors: getRandomColors()),
      Product(name: '1.4', colors: getRandomColors()),
    ],
    image: ImageRes.nokia,
  ),
  SmartphoneBrand(
    brand: 'Motorola',
    products: [
      Product(name: 'Moto G100', colors: getRandomColors()),
      Product(name: 'Moto G60', colors: getRandomColors()),
      Product(name: 'Moto G50', colors: getRandomColors()),
      Product(name: 'Moto G30', colors: getRandomColors()),
      Product(name: 'Moto G10', colors: getRandomColors()),
      Product(name: 'Edge 20 Pro', colors: getRandomColors()),
      Product(name: 'Edge 20', colors: getRandomColors()),
      Product(name: 'Edge 20 Lite', colors: getRandomColors()),
      Product(name: 'Edge+', colors: getRandomColors()),
      Product(name: 'Razor 5G', colors: getRandomColors()),
    ],
    image: ImageRes.motorola,
  ),
  SmartphoneBrand(
    brand: 'Lenovo',
    products: [
      Product(name: 'Legion Duel 2', colors: getRandomColors()),
      Product(name: 'Legion Duel', colors: getRandomColors()),
      Product(name: 'Z6 Pro', colors: getRandomColors()),
      Product(name: 'Z6', colors: getRandomColors()),
      Product(name: 'K10 Note', colors: getRandomColors()),
      Product(name: 'A6 Note', colors: getRandomColors()),
      Product(name: 'Z5 Pro', colors: getRandomColors()),
    ],
    image: ImageRes.lenovo,
  ),
  SmartphoneBrand(
    brand: 'Asus',
    products: [
      Product(name: 'ROG Phone 5', colors: getRandomColors()),
      Product(name: 'ROG Phone 3', colors: getRandomColors()),
      Product(name: 'Zenfone 8', colors: getRandomColors()),
      Product(name: 'Zenfone 7', colors: getRandomColors()),
      Product(name: 'Zenfone 6', colors: getRandomColors()),
      Product(name: 'ROG Phone 2', colors: getRandomColors()),
      Product(name: 'ROG Phone', colors: getRandomColors()),
    ],
    image: ImageRes.asus,
  ),
  SmartphoneBrand(
    brand: 'Realme',
    products: [
      Product(name: 'GT 2 Pro', colors: getRandomColors()),
      Product(name: 'GT 2', colors: getRandomColors()),
      Product(name: 'GT Neo 2', colors: getRandomColors()),
      Product(name: 'GT Master Edition', colors: getRandomColors()),
      Product(name: 'X7 Max 5G', colors: getRandomColors()),
      Product(name: '8 Pro', colors: getRandomColors()),
      Product(name: '7 Pro', colors: getRandomColors()),
    ],
    image: ImageRes.realme,
  ),
  SmartphoneBrand(
    brand: 'Blackberry',
    products: [
      Product(name: 'Key2', colors: getRandomColors()),
      Product(name: 'KeyOne', colors: getRandomColors()),
      Product(name: 'Motion', colors: getRandomColors()),
      Product(name: 'DTEK60', colors: getRandomColors()),
      Product(name: 'DTEK50', colors: getRandomColors()),
      Product(name: 'Priv', colors: getRandomColors()),
    ],
    image: ImageRes.blackberry,
  ),
  SmartphoneBrand(
    brand: 'Cat',
    products: [
      Product(name: 'S62 Pro', colors: getRandomColors()),
      Product(name: 'S52', colors: getRandomColors()),
      Product(name: 'S61', colors: getRandomColors()),
      Product(name: 'S41', colors: getRandomColors()),
      Product(name: 'S31', colors: getRandomColors()),
      Product(name: 'S30', colors: getRandomColors()),
    ],
    image: ImageRes.cat,
  ),
  SmartphoneBrand(
    brand: 'Alcatel',
    products: [
      Product(name: '1S', colors: getRandomColors()),
      Product(name: '3L', colors: getRandomColors()),
      Product(name: '1V', colors: getRandomColors()),
      Product(name: '1B', colors: getRandomColors()),
      Product(name: '1SE', colors: getRandomColors()),
    ],
    image: ImageRes.alcatel,
  ),
  SmartphoneBrand(
    brand: 'Honor',
    products: [
      Product(name: 'Magic4 Pro', colors: getRandomColors()),
      Product(name: 'Magic4', colors: getRandomColors()),
      Product(name: 'Magic V', colors: getRandomColors()),
      Product(name: '50 Pro', colors: getRandomColors()),
      Product(name: '50', colors: getRandomColors()),
      Product(name: '30 Pro+', colors: getRandomColors()),
      Product(name: '30 Pro', colors: getRandomColors()),
      Product(name: '30', colors: getRandomColors()),
    ],
    image: ImageRes.honor,
  ),
];

class Accessory {
  final String image;
  final String title;
  final String description;
  final String price;

  Accessory({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

List<Accessory> accessoriesList = [
  Accessory(
    image: ImageRes.screenProtector,
    title: 'Screen Protector',
    description: 'Protect your phone screen from scratches and minor impacts.',
    price: '15.95',
  ),
  Accessory(
    image: ImageRes.safetyGlass,
    title: 'Safety Glass',
    description: 'Durable glass protection to prevent screen shattering.',
    price: '25.95',
  ),
  Accessory(
    image: ImageRes.siliconCase,
    title: 'Silicon Case',
    description: 'Flexible and lightweight case to protect your phone.',
    price: '20.95',
  ),
  Accessory(
    image: ImageRes.phoneBookCase,
    title: 'Phone Book Case',
    description: 'Stylish and functional phone case with additional storage.',
    price: '30.95',
  ),
];
