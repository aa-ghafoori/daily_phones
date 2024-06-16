import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_phones/src/repair/domain/usecases/usecases.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

part 'repair_event.dart';
part 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc({
    required GetAccessories getAccessories,
    required GetBrands getBrands,
    required GetProducts getProducts,
    required GetRepairs getRepairs,
  })  : _getAccessories = getAccessories,
        _getBrands = getBrands,
        _getProducts = getProducts,
        _getRepairs = getRepairs,
        super(const RepairState()) {
    on<RepairStarted>(_onRepairStarted);
    on<RepairProductsFiltered>(_onRepairProductsFiltered);
    on<RepairProductSelected>(_onRepairProductSelected);
    on<RepairProductColorSelected>(_onRepairProductColorSelected);
    on<RepairItemAdded>(_onRepairItemAdded);
    on<RepairItemRemoved>(_onRepairItemRemoved);
  }

  final GetAccessories _getAccessories;

  final GetBrands _getBrands;

  final GetProducts _getProducts;

  final GetRepairs _getRepairs;

  List<Product> _products = [];

  Future<void> _onRepairStarted(
      RepairStarted event, Emitter<RepairState> emit) async {
    emit(const RepairLoadInProgress());

    final brands =
        await _getBrands(const GetBrandsParams(type: ProductType.smartphone));

    brands.fold(
        (failure) => RepairBrandsLoadFailure(
            message: failure.message, statusCode: failure.statusCode),
        (brands) => emit(RepairBrandsLoadSuccess(brands)));

    final products = await _getProducts(const GetProductsParams());

    products.fold(
        (failure) => emit(RepairProductsLoadFailure(
              message: failure.message,
              statusCode: failure.statusCode,
            )), (products) {
      _products = products;
      emit(RepairProductsLoadSuccess(products));
    });
  }

  Future<void> _onRepairProductsFiltered(
      RepairProductsFiltered event, Emitter<RepairState> emit) async {
    final filteredProducts = _products
        .where((product) =>
            product.brand.toLowerCase().contains(event.text.toLowerCase()) ||
            product.name.toLowerCase().contains(event.text.toLowerCase()))
        .toList();
    emit(RepairProductsFilterSuccess(filteredProducts));
  }

  Future<void> _onRepairProductSelected(
      RepairProductSelected event, Emitter<RepairState> emit) async {
    if (state.product != event.product) {
      emit(
        state.copyWith(status: RepairStatus.loading, product: event.product),
      );

      final accessories = await _getAccessories(
        GetAccessoriesParams(product: event.product),
      );

      accessories.fold(
        (failure) => emit(state.copyWith(status: RepairStatus.failure)),
        (accessories) => emit(
          state.copyWith(
              accessories: accessories, status: RepairStatus.success),
        ),
      );
      final repairs = await _getRepairs(
        GetRepairsParams(product: event.product),
      );

      repairs.fold(
        (failure) => emit(
          state.copyWith(status: RepairStatus.failure),
        ),
        (repairs) => emit(
          state.copyWith(repairs: repairs, status: RepairStatus.success),
        ),
      );
    }
  }

  void _onRepairProductColorSelected(
      RepairProductColorSelected event, Emitter<RepairState> emit) {
    emit(state.copyWith(
        selectedColor: event.productColor, status: RepairStatus.success));
  }

  void _onRepairItemAdded(RepairItemAdded event, Emitter<RepairState> emit) {
    final updatedItems = List<CheckoutItem>.from(state.selectedItems)
      ..add(event.item);
    emit(
      state.copyWith(selectedItems: updatedItems, status: RepairStatus.success),
    );
  }

  void _onRepairItemRemoved(
      RepairItemRemoved event, Emitter<RepairState> emit) {
    final updatedItems = List<CheckoutItem>.from(state.selectedItems)
      ..remove(event.item);
    emit(
      state.copyWith(selectedItems: updatedItems),
    );
  }
}
