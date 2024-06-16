part of 'repair_bloc.dart';

sealed class RepairEvent extends Equatable {
  const RepairEvent();

  @override
  List<Object> get props => [];
}

final class RepairStarted extends RepairEvent {}

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
