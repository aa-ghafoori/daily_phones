part of 'repair_bloc.dart';

enum RepairStatus { initial, loading, success, failure }

final class RepairState extends Equatable {
  const RepairState({
    this.product,
    this.selectedColor,
    this.accessories = const [],
    this.repairs = const [],
    this.selectedItems = const [],
    this.status = RepairStatus.initial,
  });

  final Product? product;

  final ProductColor? selectedColor;

  final List<Accessory> accessories;

  final List<Repair> repairs;

  final List<CheckoutItem> selectedItems;

  final RepairStatus status;

  RepairState copyWith({
    Product? product,
    ProductColor? selectedColor,
    List<Accessory>? accessories,
    List<Repair>? repairs,
    List<CheckoutItem>? selectedItems,
    RepairStatus? status,
  }) {
    return RepairState(
      product: product ?? this.product,
      selectedColor: selectedColor ?? this.selectedColor,
      accessories: accessories ?? this.accessories,
      repairs: repairs ?? this.repairs,
      selectedItems: selectedItems ?? this.selectedItems,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [product, selectedColor, accessories, repairs, selectedItems, status];
}

final class RepairLoadInProgress extends RepairState {
  const RepairLoadInProgress();
}

final class RepairProductsLoadSuccess extends RepairState {
  const RepairProductsLoadSuccess(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

final class RepairProductsLoadFailure extends RepairState {
  const RepairProductsLoadFailure({
    required this.message,
    required this.statusCode,
  });

  final String message;

  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

final class RepairBrandsLoadSuccess extends RepairState {
  const RepairBrandsLoadSuccess(this.brands);

  final List<Brand> brands;

  @override
  List<Object> get props => [brands];
}

final class RepairBrandsLoadFailure extends RepairState {
  const RepairBrandsLoadFailure({
    required this.message,
    required this.statusCode,
  });

  final String message;

  final String statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

final class RepairProductsFilterSuccess extends RepairState {
  const RepairProductsFilterSuccess(this.products);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}
