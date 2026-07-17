import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'database_helper.dart';

class AuthDatabase {
  AuthDatabase._internal();

  static final AuthDatabase instance = AuthDatabase._internal();

  Future<void> get database => DatabaseHelper.instance.database;

  String _generarSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  String _hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }

  Future<bool> registerUser({
    required String nombre,
    required String email,
    required String password,
  }) async {
    final db = await DatabaseHelper.instance.database;
    final normalizedEmail = email.trim().toLowerCase();

    final existentes = await db.query(
      DatabaseHelper.tableUsuarios,
      where: 'correo = ?',
      whereArgs: [normalizedEmail],
      limit: 1,
    );

    if (existentes.isNotEmpty) {
      return false;
    }

    final salt = _generarSalt();
    final hash = _hashPassword(password, salt);

    await db.insert(DatabaseHelper.tableUsuarios, {
      'nombre': nombre.trim(),
      'correo': normalizedEmail,
      'passwordHash': hash,
      'salt': salt,
      'fechaRegistro': DateTime.now().toIso8601String(),
    });

    return true;
  }

  Future<bool> authenticateUser({
    required String email,
    required String password,
  }) async {
    final db = await DatabaseHelper.instance.database;
    final normalizedEmail = email.trim().toLowerCase();

    final resultados = await db.query(
      DatabaseHelper.tableUsuarios,
      where: 'correo = ?',
      whereArgs: [normalizedEmail],
      limit: 1,
    );

    if (resultados.isEmpty) {
      return false;
    }

    final usuario = resultados.first;
    final salt = usuario['salt'] as String;
    final hashGuardado = usuario['passwordHash'] as String;

    return _hashPassword(password, salt) == hashGuardado;
  }
}
