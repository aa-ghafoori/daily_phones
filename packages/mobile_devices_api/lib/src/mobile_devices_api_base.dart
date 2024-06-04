import 'package:mobile_devices_api/mobile_devices_api.dart';

abstract class MobileDevicesApi {
  const MobileDevicesApi();

  Stream<List<Product>> getProducts({ProductType? type, String? brand});

  Stream<List<ProductColor>> getProductColors(Product product);

  Stream<List<Brand>> getBrands(ProductType type);

  Stream<List<Repair>> getRepairs(Product product);

  Stream<List<Accessory>> getAccessories(Product product);

  Future<void> close();
}

class TodoNotFoundException implements Exception {}
