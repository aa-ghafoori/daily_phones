import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/res/predefined_data.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RepairRemoteDataSrc {
  const RepairRemoteDataSrc();

  Future<List<AccessoryModel>> getAccessories(ProductModel product);

  Future<List<BrandModel>> getBrands(ProductTypeModel type);

  Future<List<ProductTypeModel>> getProductTypes();

  Future<List<ProductModel>> getProducts({
    ProductTypeModel? type,
    BrandModel? brand,
  });

  Future<List<RepairModel>> getRepairs(ProductModel product);
}

class RepairRemoteDataSrcImpl implements RepairRemoteDataSrc {
  RepairRemoteDataSrcImpl(this.supabase);

  final SupabaseClient supabase;

  Future<List<T>> _getData<T>(
    Future<List<DataMap>> Function() query,
    T Function(DataMap) fromMap,
  ) async {
    try {
      final response = await query();
      return response.map(fromMap).toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.toString(), statusCode: e.code);
    } catch (e, stackTrace) {
      redPrint(stackTrace.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AccessoryModel>> getAccessories(ProductModel product) async {
    return _getData(
      () => supabase.rpc(
        'get_accessories_by_product',
        params: {'p_product_id': product.id},
      ),
      AccessoryModel.fromMap,
    );
  }

  @override
  Future<List<BrandModel>> getBrands(ProductTypeModel type) async {
    return _getData(
      () => supabase.rpc('get_brands_by_type', params: {'b_type_id': type.id}),
      (map) => BrandModel.fromMap(map['brand'] as DataMap),
    );
  }

  @override
  Future<List<ProductTypeModel>> getProductTypes() async {
    return _getData(
      () => supabase.from('type').select(),
      ProductTypeModel.fromMap,
    );
  }

  @override
  Future<List<ProductModel>> getProducts({
    ProductTypeModel? type,
    BrandModel? brand,
  }) async {
    return _getData(
      () => supabase.rpc(
        'get_products',
        params: {'p_brand_id': brand?.id, 'p_type_id': type?.id},
      ),
      ProductModel.fromMap,
    );
  }

  @override
  Future<List<RepairModel>> getRepairs(ProductModel product) async {
    return _getData(
      () => supabase
          .rpc('get_repairs_by_product', params: {'p_product_id': product.id}),
      RepairModel.fromMap,
    );
  }
}
