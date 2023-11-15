class Contenedor {
  final int idContenedor;
  final String sscc;
  final String origen;
  final String destino;
  final double tamanno;
  final int totalBultos;
  final DateTime fecha;
  final int idManifiesto;

  Contenedor({
    required this.idContenedor,
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
      'id_contenedor': idContenedor,
      'sscc': sscc,
      'origen': origen,
      'destino': destino,
      'tamanno': tamanno,
      'total_bultos': totalBultos,
      'fecha': fecha.toIso8601String(),
      'id_manifiesto': idManifiesto,
    };
  }
}