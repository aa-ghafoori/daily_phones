part of 'repair_bloc.dart';

enum RepairStatus { initial, loading, success, failure }

final class RepairState extends Equatable {
  const RepairState({
    this.product,
    this.selectedColor,
    this.productColors = const [],
    this.accessories = const [],
    this.repairs = const [],
    this.selectedItems = const [],
    this.status = RepairStatus.initial,
  });

  final Product? product;

  final ProductColor? selectedColor;

  final List<ProductColor> productColors;

  final List<Accessory> accessories;

  final List<Repair> repairs;

  final List<Item> selectedItems;

  final RepairStatus status;

  RepairState copyWith({
    Product? product,
    ProductColor? selectedColor,
    List<ProductColor>? productColors,
    List<Accessory>? accessories,
    List<Repair>? repairs,
    List<Item>? selectedItems,
    RepairStatus? status,
  }) {
    return RepairState(
      product: product ?? this.product,
      selectedColor: selectedColor ?? this.selectedColor,
      productColors: productColors ?? this.productColors,
      accessories: accessories ?? this.accessories,
      repairs: repairs ?? this.repairs,
      selectedItems: selectedItems ?? this.selectedItems,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        product,
        selectedColor,
        productColors,
        accessories,
        repairs,
        selectedItems,
        status
      ];
}
