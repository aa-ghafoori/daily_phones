import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/errors/faluire.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/datasources/repair_local_data_src.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:dartz/dartz.dart';

class RepairRepoImpl implements RepairRepo {
  const RepairRepoImpl(this._localDataSrc);

  final RepairLocalDataSrc _localDataSrc;

  ResultFuture<T> _executeWithHandling<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return right(result);
    } on ApiException catch (e) {
      return left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Accessory>> getAccessories(Product product) =>
      _executeWithHandling(() async {
        final accessories = await _localDataSrc
            .getAccessories(ProductModel.fromEntity(product));
        return accessories;
      });

  @override
  ResultFuture<List<Brand>> getBrands(ProductType type) =>
      _executeWithHandling(() async {
        final brands = await _localDataSrc.getBrands(type);
        return brands;
      });

  @override
  ResultFuture<List<Product>> getProducts({ProductType? type, String? brand}) =>
      _executeWithHandling(() async {
        final products =
            await _localDataSrc.getProducts(type: type, brand: brand);
        return products;
      });

  @override
  ResultFuture<List<Repair>> getRepairs(Product product) =>
      _executeWithHandling(() async {
        final repairs =
            await _localDataSrc.getRepairs(ProductModel.fromEntity(product));
        return repairs;
      });
}
