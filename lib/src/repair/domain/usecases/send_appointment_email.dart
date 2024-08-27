import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class SendAppointmentEmailParams extends Equatable {
  const SendAppointmentEmailParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.appointmentDate,
    required this.repairItems,
  });

  final String name;
  final String email;
  final String phone;
  final DateTime appointmentDate;

  final List<CheckoutItem> repairItems;

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        appointmentDate,
        repairItems,
      ];
}

class SendAppointmentEmail
    extends UsecaseWithParams<void, SendAppointmentEmailParams> {
  SendAppointmentEmail(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<void> call(SendAppointmentEmailParams params) =>
      _repo.sendAppointmentEmail(
        name: params.name,
        email: params.email,
        phone: params.phone,
        appointmentDate: params.appointmentDate,
        repairItems: params.repairItems,
      );
}
