import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static const String _dbName = 'app.db';
  static const int _dbVersion = 1;

  static const String tableUsuarios = 'usuarios';
  static const String tableAutos = 'autos';

  Database? _db;

  Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final directory = await getDatabasesPath();
    final path = join(directory, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableUsuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            correo TEXT NOT NULL UNIQUE,
            passwordHash TEXT NOT NULL,
            salt TEXT NOT NULL,
            fechaRegistro TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableAutos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            apiId TEXT,
            marca TEXT NOT NULL,
            modelo TEXT NOT NULL,
            anio INTEGER,
            imagenUrl TEXT,
            origen TEXT NOT NULL,
            eliminado INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }
}
