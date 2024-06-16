import 'package:daily_phones/core/usecases/usecases.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:equatable/equatable.dart';

class GetProductsParams extends Equatable {
  const GetProductsParams({this.type, this.brand});

  final ProductType? type;

  final String? brand;

  @override
  List<Object?> get props => [type, brand];
}

class GetProducts extends UsecaseWithParams<List<Product>, GetProductsParams> {
  const GetProducts(this._repo);

  final RepairRepo _repo;

  @override
  ResultFuture<List<Product>> call(GetProductsParams params) =>
      _repo.getProducts(type: params.type, brand: params.brand);
}
