import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class GetAccessoriesParams extends Equatable {
  const GetAccessoriesParams({required this.product});

  final Product product;

  @override
  List<Object?> get props => [product];
}

class GetAccessories
    extends UsecaseWithParams<List<Accessory>, GetAccessoriesParams> {
  const GetAccessories(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<List<Accessory>> call(GetAccessoriesParams params) =>
      _repo.getAccessories(params.product);
}
