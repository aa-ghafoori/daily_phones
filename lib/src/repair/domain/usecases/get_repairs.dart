import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class GetRepairsParams extends Equatable {
  const GetRepairsParams({required this.product});

  final Product product;

  @override
  List<Object?> get props => [product];
}

class GetRepairs extends UsecaseWithParams<List<Repair>, GetRepairsParams> {
  const GetRepairs(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<List<Repair>> call(GetRepairsParams params) =>
      _repo.getRepairs(params.product);
}
