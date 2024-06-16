// ignore_for_file: lines_longer_than_80_chars

import 'package:daily_phones/core/database/database_helper.dart';
import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class RepairLocalDataSrc {
  const RepairLocalDataSrc();

  Future<void> close();

  Future<List<AccessoryModel>> getAccessories(ProductModel product);

  Future<List<BrandModel>> getBrands(ProductType type);

  Future<List<ProductModel>> getProducts({ProductType? type, String? brand});

  Future<List<RepairModel>> getRepairs(ProductModel product);
}

class RepairLocalDataSrcImpl implements RepairLocalDataSrc {
  const RepairLocalDataSrcImpl(this._databaseHelper);

  final DatabaseHelper _databaseHelper;

  Future<Database> get _db async => _databaseHelper.database;

  Future<List<T>> _executeQuery<T>(
    String table, {
    required T Function(DataMap map) fromMap,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await _db;
      final List<DataMap> maps = await db.query(
        table,
        where: where,
        whereArgs: whereArgs,
      );

      return List<T>.from(
        maps.map((map) => fromMap(map)),
      );
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<void> close() async {
    try {
      final db = await _db;
      await db.close();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<AccessoryModel>> getAccessories(ProductModel product) async =>
      _executeQuery(
        'accessories',
        where:
            'id IN (SELECT accessoryId FROM product_accessories WHERE productId = ?)',
        whereArgs: [product.id],
        fromMap: AccessoryModel.fromMap,
      );

  @override
  Future<List<BrandModel>> getBrands(ProductType type) async => _executeQuery(
        'brands',
        where: 'types LIKE ?',
        whereArgs: ['%${ProductModel.productTypeToString(type)}%'],
        fromMap: BrandModel.fromMap,
      );

  @override
  Future<List<ProductModel>> getProducts({
    ProductType? type,
    String? brand,
  }) async {
    String? where;
    List<Object?>? whereArgs;

    if (type != null && brand != null) {
      where = 'type = ? AND brand = ?';
      whereArgs = [ProductModel.productTypeToString(type), brand];
    } else if (type != null) {
      where = 'type = ?';
      whereArgs = [ProductModel.productTypeToString(type)];
    } else if (brand != null) {
      where = 'brand = ?';
      whereArgs = [brand];
    }

    return _executeQuery(
      'products',
      where: where,
      whereArgs: whereArgs,
      fromMap: ProductModel.fromMap,
    );
  }

  @override
  Future<List<RepairModel>> getRepairs(ProductModel product) async =>
      _executeQuery(
        'repairs',
        where:
            'id IN (SELECT repairId FROM product_repairs WHERE productId = ?)',
        whereArgs: [product.id],
        fromMap: RepairModel.fromMap,
      );
}
