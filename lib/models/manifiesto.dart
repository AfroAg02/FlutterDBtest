class Manifiesto {
  final int idManifiesto;
  final DateTime fechaCarga;
  final String rutaArchivo;
  final String nombreInterno;
  final String exportadora;

  Manifiesto({
    required this.idManifiesto,
    required this.fechaCarga,
    required this.rutaArchivo,
    required this.nombreInterno,
    required this.exportadora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_manifiesto': idManifiesto,
      'fecha_carga': fechaCarga.toIso8601String(),
      'ruta_archivo': rutaArchivo,
      'nombre_interno': nombreInterno,
      'exportadora': exportadora,
    };
  }
  
}