import 'package:daily_phones/core/res/image_resourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

void redPrint(String text) {
  debugPrint("\u001b[1;31m $text");
}

void greenPrint(String text) {
  debugPrint("\u001b[1;32m $text");
}

void yellowPrint(String text) {
  debugPrint("\u001b[1;33m $text");
}

List<String> storeList = [
  'Reparaties',
  'Smartphones',
  'Screenprotector',
  'Accessories',
  'Laptops',
  'iPads/Tablets'
];

List<String> dailyPhonesList = [
  'Privacybeleid',
  'Algemene Voorwaarden',
  'Garantiebeleid',
  'Retourbeleid',
  'Betaalmethoden',
  'Verzending',
  'klachtenprocedure'
];

List<String> footerImages = [
  ImageRes.marktplace,
  ImageRes.facebook,
  ImageRes.google2,
  ImageRes.instagram
];

List<Brand> predefinedBrands = [
  Brand(name: 'Apple', imageUrl: ImageRes.apple, types: const [
    ProductType.smartphone,
    ProductType.laptop,
    ProductType.smartwatch
  ]),
  Brand(
      name: 'Samsung',
      imageUrl: ImageRes.samsung,
      types: const [ProductType.smartphone, ProductType.smartwatch]),
  Brand(
      name: 'Google',
      imageUrl: ImageRes.google,
      types: const [ProductType.smartphone, ProductType.laptop]),
  Brand(
      name: 'OnePlus',
      imageUrl: ImageRes.oneplus,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Sony',
      imageUrl: ImageRes.sony,
      types: const [ProductType.smartphone, ProductType.laptop]),
  Brand(
      name: 'Xiaomi',
      imageUrl: ImageRes.xiaomi,
      types: const [ProductType.smartphone, ProductType.smartwatch]),
  Brand(
      name: 'Oppo',
      imageUrl: ImageRes.oppo,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Huawei',
      imageUrl: ImageRes.huawei,
      types: const [ProductType.smartphone, ProductType.laptop]),
  Brand(
      name: 'LG',
      imageUrl: ImageRes.lg,
      types: const [ProductType.smartphone, ProductType.smartwatch]),
  Brand(
      name: 'Nokia',
      imageUrl: ImageRes.nokia,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Motorola',
      imageUrl: ImageRes.motorola,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Lenovo',
      imageUrl: ImageRes.lenovo,
      types: const [ProductType.smartphone, ProductType.laptop]),
  Brand(
      name: 'Asus',
      imageUrl: ImageRes.asus,
      types: const [ProductType.smartphone, ProductType.laptop]),
  Brand(
      name: 'Realme',
      imageUrl: ImageRes.realme,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Blackberry',
      imageUrl: ImageRes.blackberry,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Cat',
      imageUrl: ImageRes.cat,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Alcatel',
      imageUrl: ImageRes.alcatel,
      types: const [ProductType.smartphone]),
  Brand(
      name: 'Honor',
      imageUrl: ImageRes.honor,
      types: const [ProductType.smartphone, ProductType.laptop]),
];

List<Product> predefinedProducts = [
  Product(
    name: 'iPhone 14',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 14 Plus',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 14 Pro',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 14 Pro Max',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 13',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 13 mini',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 13 Pro',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 13 Pro Max',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 12',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 12 mini',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 12 Pro',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone 12 Pro Max',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'iPhone SE (2022)',
    brand: 'Apple',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S23',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S23+',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S23 Ultra',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S22',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S22+',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S22 Ultra',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy Z Fold 4',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy Z Flip 4',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy A53',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy A73',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Galaxy S21 FE',
    brand: 'Samsung',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 7',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 7 Pro',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 6',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 6 Pro',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 5',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 4a',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 5a',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 4',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 4 XL',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 3a',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Pixel 3a XL',
    brand: 'Google',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 11',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 10 Pro',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 10T',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 9',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 9 Pro',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 8T',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus Nord 2',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 8',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 8 Pro',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 7T',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'OnePlus 7T Pro',
    brand: 'OnePlus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 1 IV',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 5 IV',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 10 IV',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 1 III',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 5 III',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 10 III',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 1 II',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 5 II',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Xperia 10 II',
    brand: 'Sony',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 12',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 12 Pro',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Redmi Note 11',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Redmi Note 11 Pro',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 11',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 11 Pro',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 11 Ultra',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 10T',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mi 10T Pro',
    brand: 'Xiaomi',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Find X5',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Find X5 Pro',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Reno 8',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Reno 8 Pro',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Reno 7',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Reno 7 Pro',
    brand: 'Oppo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mate 50',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mate 50 Pro',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'P50',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'P50 Pro',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'P40',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'P40 Pro',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'P40 Pro+',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mate 40',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mate 40 Pro',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Mate 40 Pro+',
    brand: 'Huawei',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Velvet',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Wing',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'G8X ThinQ',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'V60 ThinQ',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Stylo 6',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'K92 5G',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'G8 ThinQ',
    brand: 'LG',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '7.2',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '8.3 5G',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '5.4',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '3.4',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'G50',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'G20',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'G10',
    brand: 'Nokia',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Edge 30 Pro',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Edge 30 Ultra',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G200',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G100',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G60',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G50',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G30',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G Power (2021)',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Moto G Stylus (2021)',
    brand: 'Motorola',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Legion Duel 2',
    brand: 'Lenovo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Legion Phone Duel',
    brand: 'Lenovo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Legion Y70',
    brand: 'Lenovo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Z6 Pro',
    brand: 'Lenovo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Z5s',
    brand: 'Lenovo',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'ROG Phone 7',
    brand: 'Asus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'ROG Phone 6',
    brand: 'Asus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'ROG Phone 5',
    brand: 'Asus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Zenfone 8',
    brand: 'Asus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Zenfone 7',
    brand: 'Asus',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Narzo 50',
    brand: 'Realme',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Narzo 30',
    brand: 'Realme',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Narzo 20',
    brand: 'Realme',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Narzo 10',
    brand: 'Realme',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Blackberry KEY2',
    brand: 'Blackberry',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Blackberry KEYone',
    brand: 'Blackberry',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Blackberry Motion',
    brand: 'Blackberry',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Blackberry DTEK60',
    brand: 'Blackberry',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Cat S62 Pro',
    brand: 'Cat',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Cat S52',
    brand: 'Cat',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Cat S42',
    brand: 'Cat',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Cat S41',
    brand: 'Cat',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '1S',
    brand: 'Alcatel',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '3L',
    brand: 'Alcatel',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '1V',
    brand: 'Alcatel',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: '5',
    brand: 'Alcatel',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Magic4 Pro',
    brand: 'Honor',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Magic4 Lite',
    brand: 'Honor',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Magic3',
    brand: 'Honor',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
  Product(
    name: 'Magic3 Pro',
    brand: 'Honor',
    imageUrl: ImageRes.iphone15,
    type: ProductType.smartphone,
  ),
];

List<Accessory> predefinedAccessories = [
  Accessory(
    title: 'Screen Protector',
    description: 'Protect your phone screen from scratches and minor impacts.',
    imageUrl: ImageRes.screenProtector,
    price: 15.95,
  ),
  Accessory(
    title: 'Safety Glass',
    description: 'Durable glass protection to prevent screen shattering.',
    imageUrl: ImageRes.safetyGlass,
    price: 25.95,
  ),
  Accessory(
    title: 'Silicon Case',
    description: 'Flexible and lightweight case to protect your phone.',
    imageUrl: ImageRes.siliconCase,
    price: 20.95,
  ),
  Accessory(
    title: 'Phone Book Case',
    description: 'Stylish and functional phone case with additional storage.',
    imageUrl: ImageRes.phoneBookCase,
    price: 30.95,
  ),
];

List<Repair> predefinedRepairs = [
  Repair(
    title: 'Screen',
    durationInMinutes: 30,
    price: 200,
    description:
        "Your screen is cracked, doesn't respond properly, or displays horizontal/vertical lines and/or unusual colors.",
    iconUrl: ImageRes.screen,
  ),
  Repair(
    title: 'Battery',
    durationInMinutes: 20,
    price: 100,
    description:
        'Your battery drains quickly, does not charge fully, or your phone shuts down unexpectedly.',
    iconUrl: ImageRes.charge,
  ),
  Repair(
    title: 'Charging Port',
    durationInMinutes: 45,
    price: 80,
    description:
        'Your charging port is loose, not charging, or requires constant adjusting to work.',
    iconUrl: ImageRes.charge,
  ),
  Repair(
    title: 'Camera',
    durationInMinutes: 60,
    price: 150,
    description:
        'Your camera is blurry, not focusing, or the camera app is not working.',
    iconUrl: ImageRes.camera,
  ),
  Repair(
    title: 'Software Update',
    durationInMinutes: 15,
    price: 30,
    description:
        'Your phone needs the latest software update for better performance and new features.',
    iconUrl: ImageRes.update,
  ),
  Repair(
    title: 'Water Damage',
    durationInMinutes: 120,
    price: 250,
    description:
        'Your phone was exposed to water and needs repair to restore functionality.',
    iconUrl: ImageRes.waterDrop,
  ),
  Repair(
    title: 'Vibrator',
    durationInMinutes: 25,
    price: 50,
    description:
        'Your phone’s vibrator is not working properly or not vibrating at all.',
    iconUrl: ImageRes.vibrator,
  ),
  Repair(
    title: 'SIM Card Reader',
    durationInMinutes: 30,
    price: 60,
    description:
        'Your phone is not detecting the SIM card or frequently loses signal.',
    iconUrl: ImageRes.simcard,
  ),
  Repair(
    title: 'Sensor',
    durationInMinutes: 35,
    price: 70,
    description:
        'Your phone’s sensors (e.g., proximity, accelerometer) are not working correctly.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'WiFi',
    durationInMinutes: 40,
    price: 80,
    description:
        'Your phone has difficulty connecting to WiFi networks or maintaining a stable connection.',
    iconUrl: ImageRes.wifi,
  ),
  Repair(
    title: 'Back Cover',
    durationInMinutes: 20,
    price: 40,
    description: 'Your phone’s back cover is damaged or needs replacement.',
    iconUrl: ImageRes.backCover,
  ),
  Repair(
    title: 'Microphone',
    durationInMinutes: 45,
    price: 90,
    description:
        'Your phone’s microphone is not working, making it difficult for others to hear you.',
    iconUrl: ImageRes.microphone,
  ),
  Repair(
    title: 'Speaker',
    durationInMinutes: 50,
    price: 100,
    description:
        'Your phone’s speaker is not producing sound or is producing distorted sound.',
    iconUrl: ImageRes.speaker,
  ),
  Repair(
    title: 'Button',
    durationInMinutes: 30,
    price: 50,
    description:
        'A physical button on your phone (e.g., power, volume) is not functioning correctly.',
    iconUrl: ImageRes.button,
  ),
  Repair(
    title: 'Display',
    durationInMinutes: 30,
    price: 220,
    description:
        'Your display has dead pixels, backlight issues, or discoloration.',
    iconUrl: ImageRes.screen,
  ),
  Repair(
    title: 'Home Button',
    durationInMinutes: 25,
    price: 60,
    description: 'The home button is unresponsive or stuck.',
    iconUrl: ImageRes.button,
  ),
  Repair(
    title: 'Earpiece Speaker',
    durationInMinutes: 35,
    price: 70,
    description: 'You can’t hear the other person well during calls.',
    iconUrl: ImageRes.speaker,
  ),
  Repair(
    title: 'Proximity Sensor',
    durationInMinutes: 30,
    price: 50,
    description: 'Your phone screen does not turn off during calls.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Headphone Jack',
    durationInMinutes: 40,
    price: 80,
    description: 'Your headphone jack is not working or has static noise.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Fingerprint Sensor',
    durationInMinutes: 30,
    price: 100,
    description: 'The fingerprint sensor is not recognizing fingerprints.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Volume Button',
    durationInMinutes: 25,
    price: 40,
    description: 'The volume button is stuck or unresponsive.',
    iconUrl: ImageRes.button,
  ),
  Repair(
    title: 'Power Button',
    durationInMinutes: 25,
    price: 40,
    description: 'The power button is stuck or unresponsive.',
    iconUrl: ImageRes.button,
  ),
  Repair(
    title: 'Mute Switch',
    durationInMinutes: 20,
    price: 30,
    description: 'The mute switch is stuck or unresponsive.',
    iconUrl: ImageRes.button,
  ),
  Repair(
    title: 'Back Camera Lens',
    durationInMinutes: 60,
    price: 120,
    description: 'The back camera lens is cracked or scratched.',
    iconUrl: ImageRes.camera,
  ),
  Repair(
    title: 'Front Camera',
    durationInMinutes: 45,
    price: 100,
    description: 'The front camera is blurry or not working.',
    iconUrl: ImageRes.camera,
  ),
  Repair(
    title: 'Network Issues',
    durationInMinutes: 60,
    price: 150,
    description: 'Your phone has trouble connecting to the mobile network.',
    iconUrl: ImageRes.simcard,
  ),
  Repair(
    title: 'Bluetooth',
    durationInMinutes: 30,
    price: 80,
    description: 'Your phone has trouble connecting to Bluetooth devices.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Face ID',
    durationInMinutes: 50,
    price: 200,
    description: 'Face ID is not working or not recognizing your face.',
    iconUrl: ImageRes.camera,
  ),
  Repair(
    title: 'Data Recovery',
    durationInMinutes: 120,
    price: 300,
    description: 'Recover lost or deleted data from your phone.',
    iconUrl: ImageRes.update,
  ),
  Repair(
    title: 'Motherboard',
    durationInMinutes: 180,
    price: 400,
    description: 'Repair or replace a faulty motherboard.',
    iconUrl: ImageRes.investigation,
  ),
  Repair(
    title: 'Antenna',
    durationInMinutes: 45,
    price: 100,
    description: 'Fix issues with weak or no signal.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Loudspeaker',
    durationInMinutes: 50,
    price: 90,
    description: 'Repair or replace a faulty loudspeaker.',
    iconUrl: ImageRes.speaker,
  ),
  Repair(
    title: 'MicroSD Slot',
    durationInMinutes: 35,
    price: 60,
    description: 'The MicroSD slot is not reading cards or is damaged.',
    iconUrl: ImageRes.simcard,
  ),
  Repair(
    title: 'GPS',
    durationInMinutes: 40,
    price: 80,
    description:
        'Your phone has issues with GPS accuracy or not detecting location.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Vibration Motor',
    durationInMinutes: 25,
    price: 50,
    description: 'Your phone’s vibration motor is weak or not working at all.',
    iconUrl: ImageRes.vibrator,
  ),
  Repair(
    title: 'Proximity Sensor Calibration',
    durationInMinutes: 20,
    price: 30,
    description: 'Calibrate the proximity sensor for accurate detection.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Light Sensor',
    durationInMinutes: 25,
    price: 50,
    description:
        'The light sensor is not adjusting the screen brightness automatically.',
    iconUrl: ImageRes.sensor,
  ),
  Repair(
    title: 'Gyroscope',
    durationInMinutes: 30,
    price: 70,
    description:
        'The gyroscope is not functioning, affecting screen rotation and gaming.',
    iconUrl: ImageRes.sensor,
  ),
];

List<ProductColor> predefinedColors = [
  ProductColor(name: 'Black', hex: '#494C50'),
  ProductColor(name: 'Red', hex: '#C34239'),
  ProductColor(name: 'Blue', hex: '#6798C9'),
  ProductColor(name: 'Green', hex: '#D5DDCE'),
  ProductColor(name: 'Yellow', hex: '#D0BD60'),
  ProductColor(name: 'Purple', hex: '#9C27B0'),
  ProductColor(name: 'Pink', hex: '#E8D5D4'),
  ProductColor(name: 'Gold', hex: '#F8E5BD'),
  ProductColor(name: 'Silver', hex: '#E3E4DE'),
];
