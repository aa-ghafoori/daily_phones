import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class DeliveryMethod extends Equatable {}

class StorePickup extends DeliveryMethod {
  StorePickup({this.appointmentDate, this.address});

  final DateTime? appointmentDate;
  final String? address;

  StorePickup copyWith({
    DateTime? appointmentDate,
    String? address,
  }) {
    return StorePickup(
      appointmentDate: appointmentDate ?? this.appointmentDate,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [appointmentDate, address];
}

class ShipDevice extends DeliveryMethod {
  ShipDevice({required this.formKey});

  final GlobalKey<FormState> formKey;

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }

  void saveForm() {
    formKey.currentState!.save();
  }

  @override
  List<Object> get props => [formKey];
}
