class Escaneo {
  final String descripcion;
  final DateTime fecha;
  final String estado;
  final int idPaquete;

  Escaneo({
    required this.descripcion,
    required this.fecha,
    required this.estado,
    required this.idPaquete,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
      'id_paquete': idPaquete,
    };
  }

  factory Escaneo.fromMap(Map<String, dynamic> map) {
    return Escaneo(
      descripcion: map['descripcion'],
      fecha: DateTime.parse(map['fecha']),
      estado: map['estado'],
      idPaquete: map['id_paquete'],
    );
  }
}
