class Auto {
  final int? id;
  final String? apiId;
  final String marca;
  final String modelo;
  final int? anio;
  final String origen;
  final bool eliminado;

  const Auto({
    this.id,
    this.apiId,
    required this.marca,
    required this.modelo,
    this.anio,
    required this.origen,
    this.eliminado = false,
  });

  Auto copyWith({
    int? id,
    String? apiId,
    String? marca,
    String? modelo,
    int? anio,
    String? origen,
    bool? eliminado,
  }) {
    return Auto(
      id: id ?? this.id,
      apiId: apiId ?? this.apiId,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      origen: origen ?? this.origen,
      eliminado: eliminado ?? this.eliminado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'apiId': apiId,
      'marca': marca,
      'modelo': modelo,
      'anio': anio,
      'origen': origen,
      'eliminado': eliminado ? 1 : 0,
    };
  }

  factory Auto.fromMap(Map<String, dynamic> map) {
    return Auto(
      id: map['id'] as int?,
      apiId: map['apiId'] as String?,
      marca: map['marca'] as String,
      modelo: map['modelo'] as String,
      anio: map['anio'] as int?,
      origen: map['origen'] as String,
      eliminado: (map['eliminado'] as int? ?? 0) == 1,
    );
  }
}
