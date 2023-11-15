class Escaneo {
  final int idEscaneo;
  final String descripcion;
  final DateTime fecha;
  final String estado;
  final int idPaquete;

  Escaneo({
    required this.idEscaneo,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    required this.idPaquete,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_escaneo': idEscaneo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
      'id_paquete': idPaquete,
    };
  }
}
