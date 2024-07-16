import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseHelper {
  DatabaseHelper(this.supabase);

  final SupabaseClient supabase;

  Future<void> _executeQuery(Future<void> Function() query) async {
    try {
      await query();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: 'message: ${e.message}, details: ${e.details}',
        statusCode: e.code,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> _upsert(
    String table,
    List<DataMap> data,
    List<String> onConflict,
  ) async {
    await _executeQuery(() async {
      await supabase.rpc<void>(
        'add_data_to_table',
        params: {
          'table_name': table,
          'conflict_columns': onConflict,
          'data': data,
        },
      );
    });
  }

  //insert into type table

  Future<void> insertType(List<ProductTypeModel> types) async {
    await _upsert('type', types.map((type) => type.toMap()).toList(), ['name']);
  }

  // Insert into brand table
  Future<void> insertBrand(List<BrandModel> brands) async {
    await _upsert(
      'brand',
      brands.map((brand) => brand.toMap()).toList(),
      ['name'],
    );
    await linkBrandType(brands);
  }

  // Insert into brand_type table
  Future<void> linkBrandType(List<BrandModel> brands) async {
    final List<DataMap> brandTypeEntries = brands
        .expand(
          (brand) => brand.types.map(
            (type) => {
              'brand_id': brand.id,
              'type_id': type.id,
            },
          ),
        )
        .toList();
    await _upsert(
      'brand_type',
      brandTypeEntries,
      ['brand_id,type_id'],
    );
  }

  // Insert into color table
  Future<void> insertColor(List<ProductColorModel> colors) async {
    await _upsert(
      'color',
      colors.map((color) => color.toMap()).toList(),
      ['name'],
    );
  }

  // Insert into product_color table
  Future<void> linkProductColor(ProductModel product) async {
    final List<DataMap> productColorEntries = product.colors
        .map((color) => {'product_id': product.id, 'color_id': color.id})
        .toList();
    await _upsert(
      'product_color',
      productColorEntries,
      ['product_id', 'color_id'],
    );
  }

  // Insert into product table
  Future<void> insertProduct(ProductModel product) async {
    await insertBrand([BrandModel.fromEntity(product.brand)]);
    await insertColor(
      product.colors.map(ProductColorModel.fromEntity).toList(),
    );
    await _upsert(
      'product',
      [product.toMap()],
      ['name'],
    );
    await linkProductColor(product);
  }

  // Insert into repair table
  Future<void> insertRepair(List<RepairModel> repairs) async {
    await _upsert(
      'repair',
      repairs.map((repair) => repair.toMap()).toList(),
      ['name'],
    );
    await insertRepairOption(repairs);
  }

  // Insert into repair_option (spare_part) table
  Future<void> insertRepairOption(List<RepairModel> repairs) async {
    final sparePartEntries = repairs.expand((repair) {
      return repair.repairOptions?.map(
            (sparePart) => {
              ...SparePartModel.fromEntity(sparePart).toMap(),
              'repair_id': repair.id,
            },
          ) ??
          <DataMap>[];
    }).toList();

    if (sparePartEntries.isNotEmpty) {
      await _upsert('repair_option', sparePartEntries, []);
    }
  }

  // Insert into product_repair table
  Future<void> linkProductRepair(
    ProductModel product,
    List<RepairModel> repairs,
  ) async {
    final List<DataMap> productRepairEntries = repairs
        .map(
          (repair) => {
            'product_id': product.id,
            'repair_id': repair.id,
            'base_price': repair.price,
          },
        )
        .toList();

    await _upsert(
      'product_repair',
      productRepairEntries,
      ['product_id', 'repair_id'],
    );

    final allRepairOptions = repairs.expand(
      (repair) {
        if (repair.repairOptions != null) {
          return repair.repairOptions!.map(SparePartModel.fromEntity);
        }
        return <SparePartModel>[];
      },
    ).toList();

    if (allRepairOptions.isNotEmpty) {
      await linkProductRepairOption(product, allRepairOptions);
    }
  }

  // Insert into product_repair_option table
  Future<void> linkProductRepairOption(
    ProductModel product,
    List<SparePartModel> repairOptions,
  ) async {
    final List<DataMap> productRepairOptionEntries = repairOptions
        .map(
          (repairOption) => {
            'product_id': product.id,
            'repair_option_id': repairOption.id,
            'price': repairOption.price,
          },
        )
        .toList();
    await _upsert(
      'product_repair_option',
      productRepairOptionEntries,
      ['product_id', 'repair_option_id'],
    );
  }

  // Insert into accessory table
  Future<void> insertAccessory(List<AccessoryModel> accessories) async {
    await _upsert(
      'accessory',
      accessories.map((accessory) => accessory.toMap()).toList(),
      ['name'],
    );
  }

  // Insert into product_accessory table
  Future<void> linkProductAccessory(
    ProductModel product,
    List<AccessoryModel> accessories,
  ) async {
    final List<DataMap> productAccessoryEntries = accessories
        .map(
          (accessory) =>
              {'product_id': product.id, 'accessory_id': accessory.id},
        )
        .toList();
    await _upsert(
      'product_accessory',
      productAccessoryEntries,
      ['product_id', 'accessory_id'],
    );
  }

  // Seed predefined data
  Future<void> seedDatabase({
    required List<ProductModel> predefinedProducts,
    required List<AccessoryModel> predefinedAccessories,
    required List<RepairModel> predefinedRepairs,
    required List<ProductTypeModel> predefinedTypes,
  }) async {
    await insertType(predefinedTypes);
    await insertAccessory(predefinedAccessories);
    await insertRepair(predefinedRepairs);
    for (final product in predefinedProducts) {
      await insertProduct(product);
      await linkProductAccessory(product, predefinedAccessories);
      await linkProductRepair(product, predefinedRepairs);
    }
  }
}
