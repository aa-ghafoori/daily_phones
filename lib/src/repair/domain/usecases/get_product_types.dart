import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';

class GetProductTypes extends UsecaseWithoutParams<List<ProductType>> {
  const GetProductTypes(this._repo);

  final RepairRepo _repo;
  @override
  ResultFuture<List<ProductType>> call() => _repo.getProductTypes();
}
