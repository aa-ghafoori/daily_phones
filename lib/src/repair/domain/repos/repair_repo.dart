import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

abstract interface class RepairRepo {
  const RepairRepo();

  ResultFuture<List<Accessory>> getAccessories(Product product);

  ResultFuture<List<Brand>> getBrands(ProductType type);

  ResultFuture<List<ProductType>> getProductTypes();

  ResultFuture<List<Product>> getProducts({ProductType? type, Brand? brand});

  ResultFuture<List<Repair>> getRepairs(Product product);
}
