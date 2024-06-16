import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class GetBrandsParams extends Equatable {
  const GetBrandsParams({required this.type});

  final ProductType type;

  @override
  List<Object?> get props => [type];
}

class GetBrands extends UsecaseWithParams<List<Brand>, GetBrandsParams> {
  const GetBrands(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<List<Brand>> call(GetBrandsParams params) =>
      _repo.getBrands(params.type);
}
