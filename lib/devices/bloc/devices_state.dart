part of 'devices_bloc.dart';

sealed class DevicesState extends Equatable {
  const DevicesState();

  @override
  List<Object> get props => [];
}

final class DevicesInitial extends DevicesState {}

final class DevicesLoadInProgress extends DevicesState {}

final class DevicesProductsLoadSuccess extends DevicesState {}

final class DevicesProductsLoadFailure extends DevicesState {}

final class DevicesBrandsLoadSuccess extends DevicesState {
  const DevicesBrandsLoadSuccess(this.brands);

  final List<Brand> brands;

  @override
  List<Object> get props => [];
}

final class DevicesBrandsLoadFailure extends DevicesState {}

final class DevicesFocused extends DevicesState {
  final List<Product> products;

  const DevicesFocused(this.products);

  @override
  List<Object> get props => [products];
}

final class DevicesUnfocused extends DevicesState {}
