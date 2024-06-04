import 'package:equatable/equatable.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class Item extends Equatable {
  const Item({required this.id, required this.name, required this.price});

  final String id;

  final String name;

  final double price;

  factory Item.fromRepair(Repair repair) =>
      Item(id: repair.id, name: repair.title, price: repair.price);

  factory Item.fromAccessory(Accessory accessory) =>
      Item(id: accessory.id, name: accessory.title, price: accessory.price);

  @override
  List<Object?> get props => [id, name, price];
}
