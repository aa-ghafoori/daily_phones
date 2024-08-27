part of 'repair_bloc.dart';

sealed class RepairEvent extends Equatable {
  const RepairEvent();

  @override
  List<Object> get props => [];
}

final class RepairStarted extends RepairEvent {}

final class RepairBookingScreenStarted extends RepairEvent {
  const RepairBookingScreenStarted(this.state);

  final RepairState state;

  @override
  List<Object> get props => [state];
}

final class RepairProductTypeSelected extends RepairEvent {
  const RepairProductTypeSelected(this.type);

  final ProductType type;

  @override
  List<Object> get props => [type];
}

final class RepairBrandSelected extends RepairEvent {
  const RepairBrandSelected({required this.brand, required this.type});

  final Brand brand;

  final ProductType type;

  @override
  List<Object> get props => [brand, type];
}

final class RepairNavigateBackToBrandsPressed extends RepairEvent {}

final class RepairNavigateBackToTypesPressed extends RepairEvent {}

final class RepairProductsFiltered extends RepairEvent {
  const RepairProductsFiltered(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class RepairProductSelected extends RepairEvent {
  const RepairProductSelected({required this.product});

  final Product product;

  @override
  List<Object> get props => [product];
}

final class RepairProductColorSelected extends RepairEvent {
  const RepairProductColorSelected({required this.productColor});

  final ProductColor productColor;

  @override
  List<Object> get props => [productColor];
}

final class RepairItemAdded extends RepairEvent {
  const RepairItemAdded(this.item);

  final CheckoutItem item;

  @override
  List<Object> get props => [item];
}

final class RepairItemRemoved extends RepairEvent {
  const RepairItemRemoved(this.item);

  final CheckoutItem item;

  @override
  List<Object> get props => [item];
}

final class RepairOfferFormSubmitted extends RepairEvent {
  const RepairOfferFormSubmitted({
    required this.name,
    required this.email,
    this.context,
  });

  final String name;

  final String email;

  final BuildContext? context;

  @override
  List<Object> get props => [name, email];
}

final class RepairDeliveryMethodSelected extends RepairEvent {
  const RepairDeliveryMethodSelected(this.data, {this.reset = false});

  final DeliveryMethod data;

  final bool reset;

  @override
  List<Object> get props => [data, reset];
}

final class RepairPaymentMethodSelected extends RepairEvent {
  const RepairPaymentMethodSelected(this.paymentMethod);

  final String paymentMethod;

  @override
  List<Object> get props => [paymentMethod];
}

final class RepairValidationStarted extends RepairEvent {
  const RepairValidationStarted(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [context];
}

class RepairCustomerNameUpdated extends RepairEvent {
  const RepairCustomerNameUpdated(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class RepairCustomerEmailUpdated extends RepairEvent {
  const RepairCustomerEmailUpdated(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RepairCustomerPhoneUpdated extends RepairEvent {
  const RepairCustomerPhoneUpdated(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class RepairBookingStarted extends RepairEvent {
  const RepairBookingStarted({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;

  final String email;

  final String phone;

  @override
  List<Object> get props => [name, email, phone];
}
