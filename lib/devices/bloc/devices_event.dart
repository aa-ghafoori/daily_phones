part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object> get props => [];
}

final class DevicesStarted extends DevicesEvent {}

final class DevicesFocusChanged extends DevicesEvent {
  const DevicesFocusChanged(this.isFocused);

  final bool isFocused;

  @override
  List<Object> get props => [isFocused];
}

final class DevicesTextFieldOutsideTapped extends DevicesEvent {}

final class DevicesTextChanged extends DevicesEvent {
  const DevicesTextChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
