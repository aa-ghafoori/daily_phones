import 'dart:typed_data';

import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/errors/faluire.dart';

import 'package:daily_phones/src/repair/data/datasources/repair_remote_data_src.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:dartz/dartz.dart';

class RepairRepoImpl implements RepairRepo {
  const RepairRepoImpl(this._remoteDataSrc);

  final RepairRemoteDataSrc _remoteDataSrc;

  Future<Either<Failure, T>> _executeWithHandling<T>(
      Future<T> Function() action,) async {
    try {
      final result = await action();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure(message: e.toString(), statusCode: '400'));
    }
  }

  @override
  Future<Either<Failure, List<Accessory>>> getAccessories(Product product) =>
      _executeWithHandling(
        () async => _remoteDataSrc.getAccessories(product as ProductModel),
      );

  @override
  Future<Either<Failure, List<Brand>>> getBrands(ProductType type) =>
      _executeWithHandling(
        () async => _remoteDataSrc.getBrands(type as ProductTypeModel),
      );

  @override
  Future<Either<Failure, List<ProductType>>> getProductTypes() =>
      _executeWithHandling(
        () async => _remoteDataSrc.getProductTypes(),
      );

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    ProductType? type,
    Brand? brand,
  }) =>
      _executeWithHandling(
        () async => _remoteDataSrc.getProducts(
          type: type as ProductTypeModel?,
          brand: brand as BrandModel?,
        ),
      );

  @override
  Future<Either<Failure, List<Repair>>> getRepairs(Product product) =>
      _executeWithHandling(
        () async => _remoteDataSrc.getRepairs(product as ProductModel),
      );

  @override
  Future<Either<Failure, void>> sendAppointmentEmail({
    required String name,
    required String email,
    required String phone,
    required DateTime appointmentDate,
    required List<CheckoutItem> repairItems,
  }) =>
      _executeWithHandling(
        () async {
          final repairItemModels =
              repairItems.map(CheckoutItemModel.fromCheckoutItem).toList();
          return _remoteDataSrc.sendAppointmentEmail(
            name: name,
            email: email,
            phone: phone,
            appointmentDate: appointmentDate,
            repairItems: repairItemModels,
          );
        },
      );

  @override
  Future<Either<Failure, void>> sendOfferEmail({
    required Uint8List pdfData,
    required String name,
    required String email,
  }) =>
      _executeWithHandling(
        () async => _remoteDataSrc.sendOfferEmail(
          pdfData: pdfData,
          name: name,
          email: email,
        ),
      );
}
