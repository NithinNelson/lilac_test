import 'package:flutter/material.dart';
import 'package:fluttertest/sqFlite/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableUser (
    ${UserFields.id} $idType,
  ${UserFields.name} $textType,
  ${UserFields.userImage} $textType,
  ${UserFields.email} $textType,
  ${UserFields.dateOfBirth} $textType
    )
    ''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableUser,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllStudentData() async {
    final db = await instance.database;

    final result =
        await db.query(tableUser, orderBy: '${UserFields.name} ASC');

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User students) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      students.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [students.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
