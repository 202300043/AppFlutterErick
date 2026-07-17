import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HistorialService {
  HistorialService._internal();

  static final HistorialService instance = HistorialService._internal();

  static const String _nombreArchivo = 'historial.txt';

  Future<File> _archivo() async {
    final directorio = await getApplicationDocumentsDirectory();
    return File('${directorio.path}/$_nombreArchivo');
  }

  Future<void> registrarEvento(String evento) async {
    final archivo = await _archivo();
    final marcaDeTiempo = DateTime.now().toIso8601String();
    await archivo.writeAsString(
      '[$marcaDeTiempo] $evento\n',
      mode: FileMode.append,
      flush: true,
    );
  }

  Future<String> leerHistorial() async {
    final archivo = await _archivo();
    if (!await archivo.exists()) {
      return '';
    }
    return archivo.readAsString();
  }

  Future<void> limpiarHistorial() async {
    final archivo = await _archivo();
    if (await archivo.exists()) {
      await archivo.writeAsString('');
    }
  }
}
