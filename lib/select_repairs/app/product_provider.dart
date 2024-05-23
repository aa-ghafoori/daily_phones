import 'package:daily_phones/core/res/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  MyState build() {
    return MyState(product: Product.empty);
  }

  void setProduct(Product product, WidgetRef ref) {
    if (state.product != product) {
      state = MyState(product: product);
    }
  }

  void addItem(item) {
    final newList = List.from(state.selectedItems)..add(item);
    state = state.copyWith(selectedItems: newList);
  }

  void removeItem(item) {
    final newList = List.from(state.selectedItems)..remove(item);
    state = state.copyWith(selectedItems: newList);
  }

  void setSelectedColor(SmartphoneColor selectedColor) {
    state = state.copyWith(selectedColor: selectedColor);
  }
}

class MyState {
  MyState({
    required this.product,
    List? selectedItems,
    this.selectedColor,
  }) : selectedItems = selectedItems ?? [];

  final Product product;
  final List selectedItems;
  final SmartphoneColor? selectedColor;

  MyState copyWith({
    Product? product,
    List? selectedItems,
    SmartphoneColor? selectedColor,
  }) {
    return MyState(
      product: product ?? this.product,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
