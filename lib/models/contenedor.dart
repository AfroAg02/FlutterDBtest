class Contenedor {
  final String sscc;
  final String origen;
  final String destino;
  final double tamanno;
  final int totalBultos;
  final DateTime fecha;
  final int idManifiesto;

  Contenedor({
    required this.sscc,
    required this.origen,
    required this.destino,
    required this.tamanno,
    required this.totalBultos,
    required this.fecha,
    required this.idManifiesto,
  });

  Map<String, dynamic> toMap() {
    return {
      'sscc': sscc,
      'origen': origen,
      'destino': destino,
      'tamanno': tamanno,
      'total_bultos': totalBultos,
      'fecha': fecha.toIso8601String(),
      'id_manifiesto': idManifiesto,
    };
  }
  factory Contenedor.fromMap(Map<String, dynamic> map) {
  return Contenedor(
    sscc: map['sscc'],
    origen: map['origen'],
    destino: map['destino'],
    tamanno: map['tamanno'],
    totalBultos: map['total_bultos'],
    fecha: DateTime.parse(map['fecha']),
    idManifiesto: map['id_manifiesto'],
  );
}
}
