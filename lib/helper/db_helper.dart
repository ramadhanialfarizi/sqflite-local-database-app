import 'dart:io';

//import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product_model.dart';

class DatabaseHelper {
  final String _databaseName = 'my_database.db';

  // DATABASE VERSION IS OPTIONAL
  final int _databaseVersion = 1;

  // WE WANT TO CREATE A PRODUCT TABLE
  final String tableName = 'product';
  final String id = 'id';
  final String name = 'name';
  final String category = 'category';
  final String createdAt = 'created_at';
  final String updateAt = 'update_at';

  Database? _database;

  // CHECK AVAILABLE OF THE DATABASE
  Future<Database> databaseAvailable() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // INITIALIZE DATABASE
  Future _initDatabase() async {
    // for get a path from directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, onCreate: _onCreate, version: _databaseVersion);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT NULL, $category TEXT NULL, $createdAt TEXT NULL, $updateAt TEXT NULL)',
    );
  }

  // SELECT / READ  ALL DATA FROM DATABASE
  Future<List<ProductModel>> getAllData() async {
    final data = await _database!.query(tableName);
    List<ProductModel> result =
        data.map((e) => ProductModel.fromJson(e)).toList();
    return result;
  }

  // INSERT INTO DATABASE (fungsi mereturn id)
  Future<int> insertData(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableName, row);
    return query;
  }

  // UPDATE DATA
  Future<int> updateData(int idParams, Map<String, dynamic> row) async {
    final query = await _database!.update(
      tableName,
      row,
      where: '$id = ?',
      whereArgs: [idParams],
    );
    return query;
  }

  //DELETE DATA
  Future deleteData(int idParams) async {
    await _database!.delete(
      tableName,
      where: '$id = ?',
      whereArgs: [idParams],
    );
  }
}
