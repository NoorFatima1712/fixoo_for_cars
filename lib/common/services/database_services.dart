import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'seed_shops.dart';

class DatabaseService {
  // Singleton
  DatabaseService._();
  // creates the single shared instance, stored here
  static final DatabaseService instance = DatabaseService._();
  // holds the connection once opened; null until then
  Database? _db;
  // method to get the database, or check if it's connected; if not, creates it
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  //method to create the database
  Future<Database> _initDatabase() async {
    // Get a location using getDatabasesPath
    final dbPath = await getDatabasesPath();
    // path to the database
    final path = join(dbPath, 'fixoo.db');
    // opens and create the database
    return openDatabase(
      path,
      version: 1,
      // onCreate is called if the database doesn't exist
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE shops (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            address TEXT,
            landmark TEXT
          )
        ''');
        for (final shop in seedShops) {
          await db.insert('shops', shop);
        }
      },
    );
  }

  Future<void> insertShop(Map<String, dynamic> shop) async {
    final db = await instance.database;
    await db.insert('shops', shop);
  }

  Future<List<Map<String, dynamic>>> getAllShops() async {
    final db = await database;
    return db.query('shops');
  }
}
