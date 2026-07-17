import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/auto.dart';

List<Auto> _parsearRespuestasJdm(List<String> cuerpos) {
  final autos = <Auto>[];

  for (final cuerpo in cuerpos) {
    final decodificado = jsonDecode(cuerpo) as Map<String, dynamic>;
    final resultados = decodificado['Results'] as List<dynamic>? ?? [];

    for (final item in resultados) {
      final mapa = item as Map<String, dynamic>;
      autos.add(
        Auto(
          apiId: mapa['Model_ID'].toString(),
          marca: mapa['Make_Name'] as String,
          modelo: mapa['Model_Name'] as String,
          origen: 'api',
        ),
      );
    }
  }

  return autos;
}

class ApiService {
  static const List<String> marcasJdm = [
    'toyota',
    'nissan',
    'honda',
    'mazda',
    'subaru',
    'mitsubishi',
    'suzuki',
    'lexus',
    'infiniti',
    'acura',
  ];

  static const String _baseUrl =
      'https://vpic.nhtsa.dot.gov/api/vehicles/GetModelsForMake';

  Future<List<Auto>> obtenerAutosJdm() async {
    final cuerpos = <String>[];

    for (final marca in marcasJdm) {
      final uri = Uri.parse('$_baseUrl/$marca?format=json');
      final respuesta = await http.get(uri).timeout(const Duration(seconds: 15));

      if (respuesta.statusCode == 200) {
        cuerpos.add(respuesta.body);
      }
    }

    return compute(_parsearRespuestasJdm, cuerpos);
  }
}
