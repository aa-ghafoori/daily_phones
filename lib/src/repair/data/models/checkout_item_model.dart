import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class CheckoutItemModel extends CheckoutItem {
  const CheckoutItemModel({
    required super.id,
    required super.name,
    required super.price,
  });
  factory CheckoutItemModel.fromCheckoutItem(CheckoutItem item) =>
      CheckoutItemModel(
        id: item.id,
        name: item.name,
        price: item.price,
      );
}
