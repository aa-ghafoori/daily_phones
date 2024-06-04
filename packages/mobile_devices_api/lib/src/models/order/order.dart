import 'package:equatable/equatable.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';

class Order extends Equatable {
  const Order({
    required this.product,
    required this.color,
    required this.shoppingList,
    required this.totalPrice,
  });

  final Product product;

  final String color;

  final List<dynamic> shoppingList;

  final double totalPrice;

  @override
  List<Object?> get props => [product, color, shoppingList, totalPrice];
}
