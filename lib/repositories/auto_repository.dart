import '../data/database_helper.dart';
import '../models/auto.dart';
import '../services/api_service.dart';

class AutoRepository {
  AutoRepository({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  Future<List<Auto>> obtenerAutos() async {
    final autosApi = await _apiService.obtenerAutosJdm();

    final db = await DatabaseHelper.instance.database;
    final filas = await db.query(DatabaseHelper.tableAutos);

    final overrides = <String, Map<String, dynamic>>{};
    final locales = <Auto>[];

    for (final fila in filas) {
      if (fila['origen'] == 'override' && fila['apiId'] != null) {
        overrides[fila['apiId'] as String] = fila;
      } else if (fila['origen'] == 'local') {
        locales.add(Auto.fromMap(fila));
      }
    }

    final resultado = <Auto>[];
    for (final auto in autosApi) {
      final override = overrides[auto.apiId];
      if (override != null) {
        if ((override['eliminado'] as int) == 1) {
          continue;
        }
        resultado.add(Auto.fromMap(override));
      } else {
        resultado.add(auto);
      }
    }

    resultado.addAll(locales);
    return resultado;
  }

  Future<void> crearAuto(Auto auto) async {
    final db = await DatabaseHelper.instance.database;
    final datos = auto.copyWith(origen: 'local').toMap()..remove('id');
    await db.insert(DatabaseHelper.tableAutos, datos);
  }

  Future<void> actualizarAuto(Auto auto) async {
    final db = await DatabaseHelper.instance.database;

    if (auto.origen == 'local' && auto.id != null) {
      await db.update(
        DatabaseHelper.tableAutos,
        auto.toMap(),
        where: 'id = ?',
        whereArgs: [auto.id],
      );
      return;
    }

    if (auto.apiId != null) {
      await _guardarOverride(auto.copyWith(origen: 'override', eliminado: false));
    }
  }

  Future<void> eliminarAuto(Auto auto) async {
    final db = await DatabaseHelper.instance.database;

    if (auto.origen == 'local' && auto.id != null) {
      await db.delete(
        DatabaseHelper.tableAutos,
        where: 'id = ?',
        whereArgs: [auto.id],
      );
      return;
    }

    if (auto.apiId != null) {
      await _guardarOverride(auto.copyWith(origen: 'override', eliminado: true));
    }
  }

  Future<void> _guardarOverride(Auto auto) async {
    final db = await DatabaseHelper.instance.database;

    final existentes = await db.query(
      DatabaseHelper.tableAutos,
      where: 'apiId = ? AND origen = ?',
      whereArgs: [auto.apiId, 'override'],
      limit: 1,
    );

    final datos = auto.toMap()..remove('id');

    if (existentes.isNotEmpty) {
      await db.update(
        DatabaseHelper.tableAutos,
        datos,
        where: 'id = ?',
        whereArgs: [existentes.first['id']],
      );
    } else {
      await db.insert(DatabaseHelper.tableAutos, datos);
    }
  }
}
