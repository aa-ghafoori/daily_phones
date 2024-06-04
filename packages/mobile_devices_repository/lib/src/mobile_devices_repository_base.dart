import 'package:mobile_devices_api/mobile_devices_api.dart';

class MobileDevicesRepository {
  const MobileDevicesRepository(this.api);

  final MobileDevicesApi api;

  Stream<List<Product>> getProducts({ProductType? type, String? brand}) =>
      api.getProducts(type: type, brand: brand);

  Stream<List<ProductColor>> getProductColors(Product product) =>
      api.getProductColors(product);

  Stream<List<Brand>> getBrands(ProductType type) => api.getBrands(type);

  Stream<List<Repair>> getRepairs(Product product) => api.getRepairs(product);

  Stream<List<Accessory>> getAccessories(Product product) =>
      api.getAccessories(product);
}
