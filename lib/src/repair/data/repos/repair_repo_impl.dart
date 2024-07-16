import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/errors/faluire.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/datasources/repair_remote_data_src.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:dartz/dartz.dart';

class RepairRepoImpl implements RepairRepo {
  const RepairRepoImpl(this._remoteDataSrc);

  final RepairRemoteDataSrc _remoteDataSrc;

  ResultFuture<T> _executeWithHandling<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Accessory>> getAccessories(Product product) =>
      _executeWithHandling(() async {
        final accessories =
            await _remoteDataSrc.getAccessories(product as ProductModel);
        return accessories;
      });

  @override
  ResultFuture<List<Brand>> getBrands(ProductType type) =>
      _executeWithHandling(() async {
        final brands = await _remoteDataSrc.getBrands(type as ProductTypeModel);
        return brands;
      });

  @override
  ResultFuture<List<ProductType>> getProductTypes() =>
      _executeWithHandling(() async {
        final productType = await _remoteDataSrc.getProductTypes();
        return productType;
      });

  @override
  ResultFuture<List<Product>> getProducts({ProductType? type, Brand? brand}) =>
      _executeWithHandling(() async {
        final products = await _remoteDataSrc.getProducts(
          type: type as ProductTypeModel?,
          brand: brand as BrandModel?,
        );
        return products;
      });

  @override
  ResultFuture<List<Repair>> getRepairs(Product product) =>
      _executeWithHandling(() async {
        final repairs =
            await _remoteDataSrc.getRepairs(product as ProductModel);
        return repairs;
      });
}
