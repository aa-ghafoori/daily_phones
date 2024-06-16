import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class CheckoutItem extends Equatable {
  const CheckoutItem(
      {required this.id, required this.name, required this.price});

  final String id;

  final String name;

  final double price;

  factory CheckoutItem.fromRepair(Repair repair) =>
      CheckoutItem(id: repair.id, name: repair.title, price: repair.price);

  factory CheckoutItem.fromAccessory(Accessory accessory) => CheckoutItem(
      id: accessory.id, name: accessory.title, price: accessory.price);

  @override
  List<Object?> get props => [id, name, price];
}
