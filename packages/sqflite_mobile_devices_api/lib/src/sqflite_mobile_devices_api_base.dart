import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteMobileDevicesApi extends MobileDevicesApi {
  static final SqfliteMobileDevicesApi _instance =
      SqfliteMobileDevicesApi._internal();

  factory SqfliteMobileDevicesApi() => _instance;

  SqfliteMobileDevicesApi._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mobile_devices.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON');

        await db.execute('''
          CREATE TABLE products (
            id TEXT NOT NULL,
            name TEXT PRIMARY KEY,
            brand TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            type TEXT NOT NULL,
            FOREIGN KEY (brand) REFERENCES brands (name)
          )
        ''');

        await db.execute('''
          CREATE TABLE colors (
            id TEXT NOT NULL,
            name TEXT PRIMARY KEY,
            hex TEXT NOT NULL
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
          CREATE TABLE product_colors (
            productId TEXT NOT NULL,
            colorId TEXT NOT NULL,
            PRIMARY KEY (productId, colorId),
            FOREIGN KEY (productId) REFERENCES products (id),
            FOREIGN KEY (colorId) REFERENCES colors (id)
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
        await db.execute(
            'CREATE INDEX idx_product_colors_productId ON product_colors (productId)');
      },
    );
  }

  Future<void> _addEntity(String table, JsonMap values) async {
    final db = await database;
    try {
      await db.insert(
        table,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log('Error adding to $table: $e');
      throw Exception('Error adding to $table');
    }
  }

  Future<void> addProduct(Product product) async {
    await _addEntity('products', product.toMap());
  }

  Future<void> addColor(ProductColor color) async {
    await _addEntity('colors', color.toMap());
  }

  Future<void> addBrand(Brand brand) async {
    await _addEntity('brands', brand.toMap());
  }

  Future<void> addAccessory(Accessory accessory) async {
    await _addEntity('accessories', accessory.toMap());
  }

  Future<void> addRepair(Repair repair) async {
    await _addEntity('repairs', repair.toMap());
  }

  Future<void> addSparePart(SparePart sparePart) async {
    await _addEntity('spare_parts', sparePart.toMap());
  }

  Future<void> linkColorToProduct(String productId, String colorId) async {
    await _addEntity('product_colors', {
      'productId': productId,
      'colorId': colorId,
    });
  }

  Future<void> linkAccessoryToProduct(
      String productId, String accessoryId) async {
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
      String repairId, String sparePartId) async {
    await _addEntity('repair_spare_parts', {
      'repairId': repairId,
      'sparePartId': sparePartId,
    });
  }

  Future<void> addColorsToProduct(
      String productId, List<ProductColor> colors) async {
    final db = await database;
    final batch = db.batch();
    for (final color in colors) {
      batch.insert(
        'colors',
        color.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.insert(
        'product_colors',
        {
          'productId': productId,
          'colorId': color.id,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> addRepairsToProduct(
      String productId, List<Repair> repairs) async {
    final db = await database;
    final batch = db.batch();
    for (final repair in repairs) {
      batch.insert(
        'repairs',
        repair.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.insert(
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
      String repairId, List<SparePart> spareParts) async {
    final db = await database;
    final batch = db.batch();
    for (final sparePart in spareParts) {
      batch.insert(
        'spare_parts',
        sparePart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.insert(
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

  Future<void> addAccessoriesToProduct(
      String productId, List<Accessory> accessories) async {
    final db = await database;
    final batch = db.batch();
    for (final accessory in accessories) {
      batch.insert(
        'accessories',
        accessory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.insert(
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

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  @override
  Stream<List<Accessory>> getAccessories(Product product) async* {
    final db = await database;
    final result = await db.query(
      'accessories',
      columns: ['id', 'title', 'description', 'imageUrl', 'price'],
      where:
          'id IN (SELECT accessoryId FROM product_accessories WHERE productId = ?)',
      whereArgs: [product.id],
    );
    yield result.map((e) => Accessory.fromMap(e)).toList();
  }

  @override
  Stream<List<Brand>> getBrands(ProductType type) async* {
    final db = await database;
    final result = await db.query(
      'brands',
      columns: ['id', 'name', 'imageUrl', 'types'],
      where: 'types LIKE ?',
      whereArgs: ['%${Product.productTypeToString(type)}%'],
    );
    yield result.map((e) => Brand.fromMap(e)).toList();
  }

  @override
  Stream<List<Product>> getProducts({ProductType? type, String? brand}) async* {
    final db = await database;
    final result = await db.query(
      'products',
      columns: ['id', 'name', 'brand', 'imageUrl', 'type'],
      where: type != null && brand != null
          ? 'type = ? AND brand = ?'
          : type != null
              ? 'type = ?'
              : brand != null
                  ? 'brand = ?'
                  : null,
      whereArgs: type != null && brand != null
          ? [Product.productTypeToString(type), brand]
          : type != null
              ? [Product.productTypeToString(type)]
              : brand != null
                  ? [brand]
                  : null,
    );
    yield result.map((e) => Product.fromMap(e)).toList();
  }

  @override
  Stream<List<ProductColor>> getProductColors(Product product) async* {
    final db = await database;
    final result = await db.query(
      'colors',
      columns: ['id', 'name', 'hex'],
      where: 'id IN (SELECT colorId FROM product_colors WHERE productId = ?)',
      whereArgs: [product.id],
    );
    yield result.map((e) => ProductColor.fromMap(e)).toList();
  }

  @override
  Stream<List<Repair>> getRepairs(Product product) async* {
    final db = await database;
    final result = await db.query(
      'repairs',
      columns: [
        'id',
        'title',
        'description',
        'durationInMinutes',
        'price',
        'iconUrl'
      ],
      where: 'id IN (SELECT repairId FROM product_repairs WHERE productId = ?)',
      whereArgs: [product.id],
    );
    yield result.map((e) => Repair.fromMap(e)).toList();
  }

  void log(String message) {
    debugPrint('[SqfliteMobileDevicesApi] $message');
  }

  Future<void> seedDatabase({
    required List<Brand> predefinedBrands,
    required List<Product> predefinedProducts,
    required List<Accessory> predefinedAccessories,
    required List<Repair> predefinedRepairs,
    required List<ProductColor> predefinedColors,
  }) async {
    List<ProductColor> generateRandomProductColors() {
      final random = Random();

      int numberOfColors = 3 + random.nextInt(4);

      List<ProductColor> shuffledColors = List.from(predefinedColors)
        ..shuffle(random);

      return shuffledColors.take(numberOfColors).toList();
    }

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

    for (final color in predefinedColors) {
      await addColor(color);
    }

    for (final product in predefinedProducts) {
      await addColorsToProduct(product.id, generateRandomProductColors());
    }

    for (final product in predefinedProducts) {
      await addAccessoriesToProduct(product.id, predefinedAccessories);
    }

    for (final product in predefinedProducts) {
      await addRepairsToProduct(product.id, predefinedRepairs);
    }
  }
}
