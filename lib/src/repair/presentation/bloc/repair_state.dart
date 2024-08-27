part of 'repair_bloc.dart';

enum RepairStatus { initial, loading, success, failure }

final class RepairState extends Equatable {
  const RepairState({
    this.products,
    this.productTypes,
    this.brands,
    this.product,
    this.selectedColor,
    this.accessories = const [],
    this.repairs = const [],
    this.selectedItems = const [],
    this.status = RepairStatus.initial,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
  });

  final List<ProductType>? productTypes;

  final List<Product>? products;

  final List<Brand>? brands;

  final Product? product;

  final ProductColor? selectedColor;

  final List<Accessory> accessories;

  final List<Repair> repairs;

  final List<CheckoutItem> selectedItems;

  final String? customerName;

  final String? customerPhone;

  final String? customerEmail;

  final RepairStatus status;

  RepairState copyWith({
    List<ProductType>? productTypes,
    List<Product>? products,
    List<Brand>? brands,
    Product? product,
    ProductColor? selectedColor,
    List<Accessory>? accessories,
    List<Repair>? repairs,
    List<CheckoutItem>? selectedItems,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    RepairStatus? status,
  }) {
    return RepairState(
      productTypes: productTypes ?? this.productTypes,
      products: products ?? this.products,
      brands: brands ?? this.brands,
      product: product ?? this.product,
      selectedColor: selectedColor ?? this.selectedColor,
      accessories: accessories ?? this.accessories,
      repairs: repairs ?? this.repairs,
      selectedItems: selectedItems ?? this.selectedItems,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        products,
        productTypes,
        brands,
        product,
        selectedColor,
        accessories,
        repairs,
        selectedItems,
        customerName,
        customerEmail,
        customerPhone,
        status,
      ];
}

final class RepairLoadInProgress extends RepairState {
  const RepairLoadInProgress({
    super.productTypes,
    super.products,
    super.brands,
  });
}

final class RepairLoadSuccess extends RepairState {
  const RepairLoadSuccess({
    super.productTypes,
    super.products,
    super.brands,
    this.filteredProducts,
  });

  final List<Product>? filteredProducts;

  @override
  List<Object?> get props => [...super.props, filteredProducts];
}

final class RepairLoadFailure extends RepairState {
  const RepairLoadFailure({
    required this.message,
    required this.statusCode,
    super.productTypes,
    super.products,
    super.brands,
  });

  final String message;

  final String statusCode;

  @override
  List<Object?> get props => [...super.props, message, statusCode];
}

final class RepairProductsFilterSuccess extends RepairState {
  const RepairProductsFilterSuccess({super.products});
}

final class RepairOfferEmailSendInProgress extends RepairState {
  const RepairOfferEmailSendInProgress({
    super.product,
    super.accessories,
    super.repairs,
    super.selectedColor,
    super.selectedItems,
  });
}

final class RepairOfferEmailSendSuccess extends RepairState {
  const RepairOfferEmailSendSuccess({
    super.product,
    super.selectedColor,
    super.selectedItems,
    super.accessories,
    super.repairs,
  });
}

final class RepairOfferEmailSendFailure extends RepairState {
  const RepairOfferEmailSendFailure({
    super.product,
    super.selectedColor,
    super.selectedItems,
    super.accessories,
    super.repairs,
  });
}

final class RepairDeliverMethodSelectSuccess extends RepairState {
  const RepairDeliverMethodSelectSuccess({super.selectedItems});
}

final class RepairValidationCheckSuccess extends RepairState {
  const RepairValidationCheckSuccess({
    super.customerName,
    super.customerEmail,
    super.customerPhone,
    super.selectedItems,
  });
}

final class RepairBookingInProgress extends RepairState {
  const RepairBookingInProgress({
    super.selectedItems,
    super.customerName,
    super.customerEmail,
    super.customerPhone,
  });
}

final class RepairBookingSuccess extends RepairState {
  const RepairBookingSuccess({
    required this.deliveryMethod,
    required this.paymentMethod,
    super.customerName,
    super.customerEmail,
    super.customerPhone,
    super.selectedItems,
  });

  final DeliveryMethod deliveryMethod;

  final String paymentMethod;

  @override
  List<Object?> get props => [...super.props, deliveryMethod, paymentMethod];
}

final class RepairBookingFailure extends RepairState {
  const RepairBookingFailure({
    required this.message,
    required this.statusCode,
    super.customerName,
    super.customerEmail,
    super.customerPhone,
    super.selectedItems,
  });

  final String message;

  final String statusCode;

  @override
  List<Object?> get props => [...super.props, message, statusCode];
}
