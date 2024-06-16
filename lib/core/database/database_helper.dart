import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'daily_phones_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    // Database tables for the Repair Feauture
    await db.execute('''
          CREATE TABLE products (
            id TEXT NOT NULL,
            name TEXT PRIMARY KEY,
            brand TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            type TEXT NOT NULL,
            colors TEXT NOT NULL,
            FOREIGN KEY (brand) REFERENCES brands (name)
          )
        ''');

    await db.execute('''
          CREATE TABLE brands (
            id TEXT NOT NULL,
            name TEXT PRIMARY KEY,
            imageUrl TEXT NOT NULL,
            types TEXT NOT NULL
          )
        ''');

    await db.execute('''
          CREATE TABLE accessories (
            id TEXT NOT NULL,
            title TEXT PRIMARY KEY,
            description TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            price REAL NOT NULL
          )
        ''');

    await db.execute('''
          CREATE TABLE repairs (
            id TEXT NOT NULL,
            title TEXT PRIMARY KEY,
            description TEXT NOT NULL,
            durationInMinutes INTEGER NOT NULL,
            price REAL NOT NULL,
            iconUrl TEXT NOT NULL
          )
        ''');

    await db.execute('''
          CREATE TABLE spare_parts (
            id TEXT NOT NULL,
            title TEXT PRIMARY KEY,
            description TEXT NOT NULL,
            price REAL NOT NULL,
            durationInMinutes INTEGER NOT NULL
          )
        ''');

    await db.execute('''
          CREATE TABLE product_accessories (
            productId TEXT NOT NULL,
            accessoryId TEXT NOT NULL,
            PRIMARY KEY (productId, accessoryId),
            FOREIGN KEY (productId) REFERENCES products (id),
            FOREIGN KEY (accessoryId) REFERENCES accessories (id)
          )
        ''');

    await db.execute('''
          CREATE TABLE product_repairs (
            productId TEXT NOT NULL,
            repairId TEXT NOT NULL,
            PRIMARY KEY (productId, repairId),
            FOREIGN KEY (productId) REFERENCES products (id),
            FOREIGN KEY (repairId) REFERENCES repairs (id)
          )
        ''');

    await db.execute('''
          CREATE TABLE repair_spare_parts (
            repairId TEXT NOT NULL,
            sparePartId TEXT NOT NULL,
            PRIMARY KEY (repairId, sparePartId),
            FOREIGN KEY (repairId) REFERENCES repairs (id),
            FOREIGN KEY (sparePartId) REFERENCES spare_parts (id)
          )
        ''');

    await db.execute('CREATE INDEX idx_product_brand ON products (brand)');
    await db.execute('CREATE INDEX idx_product_type ON products (type)');
  }

  void _log(String message) => debugPrint(message);

  Future<void> _addEntity(String table, DataMap values) async {
    final db = await database;
    try {
      await db.insert(
        table,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      _log('Error adding to $table: $e');
      throw Exception('Error adding to $table');
    }
  }

  // CRUD methods for Repair Feature
  Future<void> addProduct(ProductModel product) async {
    await _addEntity('products', product.toMap());
  }

  Future<void> addBrand(BrandModel brand) async {
    await _addEntity('brands', brand.toMap());
  }

  Future<void> addAccessory(AccessoryModel accessory) async {
    await _addEntity('accessories', accessory.toMap());
  }

  Future<void> addRepair(RepairModel repair) async {
    await _addEntity('repairs', repair.toMap());
  }

  Future<void> addSparePart(SparePartModel sparePart) async {
    await _addEntity('spare_parts', sparePart.toMap());
  }

  Future<void> linkAccessoryToProduct(
    String productId,
    String accessoryId,
  ) async {
    await _addEntity('product_accessories', {
      'productId': productId,
      'accessoryId': accessoryId,
    });
  }

  Future<void> linkRepairToProduct(String productId, String repairId) async {
    await _addEntity('product_repairs', {
      'productId': productId,
      'repairId': repairId,
    });
  }

  Future<void> linkSparePartToRepair(
    String repairId,
    String sparePartId,
  ) async {
    await _addEntity('repair_spare_parts', {
      'repairId': repairId,
      'sparePartId': sparePartId,
    });
  }

  Future<void> addAccessoriesToProduct(
    String productId,
    List<AccessoryModel> accessories,
  ) async {
    final db = await database;
    final batch = db.batch();
    for (final accessory in accessories) {
      batch
        ..insert(
          'accessories',
          accessory.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        ..insert(
          'product_accessories',
          {
            'productId': productId,
            'accessoryId': accessory.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    }
    await batch.commit(noResult: true);
  }

  Future<void> addRepairsToProduct(
    String productId,
    List<RepairModel> repairs,
  ) async {
    final db = await database;
    final batch = db.batch();
    for (final repair in repairs) {
      batch
        ..insert(
          'repairs',
          repair.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        ..insert(
          'product_repairs',
          {
            'productId': productId,
            'repairId': repair.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    }
    await batch.commit(noResult: true);
  }

  Future<void> addSparePartsToRepair(
    String repairId,
    List<SparePartModel> spareParts,
  ) async {
    final db = await database;
    final batch = db.batch();
    for (final sparePart in spareParts) {
      batch
        ..insert(
          'spare_parts',
          sparePart.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        ..insert(
          'repair_spare_parts',
          {
            'repairId': repairId,
            'sparePartId': sparePart.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    }
    await batch.commit(noResult: true);
  }

  // Seed predefined data
  Future<void> seedDatabase({
    required List<BrandModel> predefinedBrands,
    required List<ProductModel> predefinedProducts,
    required List<AccessoryModel> predefinedAccessories,
    required List<RepairModel> predefinedRepairs,
  }) async {
    for (final brand in predefinedBrands) {
      await addBrand(brand);
    }

    for (final product in predefinedProducts) {
      await addProduct(product);
    }

    for (final accessory in predefinedAccessories) {
      await addAccessory(accessory);
    }

    for (final repair in predefinedRepairs) {
      await addRepair(repair);
    }

    for (final product in predefinedProducts) {
      await addAccessoriesToProduct(product.id, predefinedAccessories);
    }

    for (final product in predefinedProducts) {
      await addRepairsToProduct(product.id, predefinedRepairs);
    }
  }
}
