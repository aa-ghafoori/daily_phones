import 'package:daily_phones/core/res/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState(product: Product.empty));

  void setProduct(Product product) {
    emit(ProductState(product: product));
  }

  void addItem(item) {
    final newList = List.from(state.selectedItems)..add(item);
    emit(state.copyWith(selectedItems: newList));
  }

  void removeItem(item) {
    final newList = List.from(state.selectedItems)..remove(item);
    emit(state.copyWith(selectedItems: newList));
  }

  void setSelectedColor(SmartphoneColor selectedColor) {
    emit(state.copyWith(selectedColor: selectedColor));
  }
}

class ProductState {
  ProductState({
    required this.product,
    List? selectedItems,
    this.selectedColor,
  }) : selectedItems = selectedItems ?? [];

  final Product product;
  final List selectedItems;
  final SmartphoneColor? selectedColor;

  ProductState copyWith({
    Product? product,
    List? selectedItems,
    SmartphoneColor? selectedColor,
  }) {
    return ProductState(
      product: product ?? this.product,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
