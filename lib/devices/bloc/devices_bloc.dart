import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final MobileDevicesRepository _mobileDevicesRepository;
  late final FocusNode _focusNode;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  DevicesBloc({required MobileDevicesRepository mobileDevicesRepository})
      : _mobileDevicesRepository = mobileDevicesRepository,
        super(DevicesInitial()) {
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    on<DevicesStarted>(_onDevicesStarted);
    on<DevicesFocusChanged>(_onDevicesFocusChanged);
    on<DevicesTextChanged>(_onDevicesTextChanged);
    on<DevicesTextFieldOutsideTapped>(_onDevicesTextFieldOutsideTapped);
  }

  Future<void> _onDevicesStarted(
      DevicesStarted event, Emitter<DevicesState> emit) async {
    emit(DevicesLoadInProgress());
    await emit.forEach(
      _mobileDevicesRepository.getProducts(),
      onData: (products) {
        _products = products;
        _filteredProducts = products;
        return DevicesProductsLoadSuccess();
      },
      onError: (_, __) => DevicesProductsLoadFailure(),
    );

    await emit.forEach(
        _mobileDevicesRepository.getBrands(ProductType.smartphone),
        onData: (brands) => DevicesBrandsLoadSuccess(brands),
        onError: (_, __) => DevicesBrandsLoadFailure());
  }

  void _onDevicesFocusChanged(
      DevicesFocusChanged event, Emitter<DevicesState> emit) {
    emit(event.isFocused
        ? DevicesFocused(_filteredProducts)
        : DevicesUnfocused());
  }

  void _onDevicesTextChanged(
      DevicesTextChanged event, Emitter<DevicesState> emit) {
    _filteredProducts = _products
        .where((product) =>
            product.brand.toLowerCase().contains(event.text.toLowerCase()) ||
            product.name.toLowerCase().contains(event.text.toLowerCase()))
        .toList();
    emit(_focusNode.hasFocus
        ? DevicesFocused(_filteredProducts)
        : DevicesUnfocused());
  }

  void _onDevicesTextFieldOutsideTapped(
      DevicesTextFieldOutsideTapped event, Emitter<DevicesState> emit) {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    emit(DevicesUnfocused());
  }

  FocusNode get focusNode => _focusNode;

  void _onFocusChange() {
    add(DevicesFocusChanged(_focusNode.hasFocus));
  }

  @override
  Future<void> close() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    return super.close();
  }
}
