import 'dart:typed_data';

import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class SendOfferEmailParams extends Equatable {
  const SendOfferEmailParams({
    required this.pdfData,
    required this.name,
    required this.email,
  });

  final Uint8List pdfData;
  final String name;
  final String email;

  @override
  List<Object> get props => [pdfData, name, email];
}

class SendOfferEmail extends UsecaseWithParams<void, SendOfferEmailParams> {
  SendOfferEmail(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<void> call(SendOfferEmailParams params) => _repo.sendOfferEmail(
        pdfData: params.pdfData,
        name: params.name,
        email: params.email,
      );
}
