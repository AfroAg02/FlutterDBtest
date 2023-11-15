class EscaneoDTO {
  final int idEscaneo;
  final String descripcion;
  final DateTime fecha;
  final Status estado;


  EscaneoDTO({
    required this.idEscaneo,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    
  });
}

enum Status {
  rechazado,
  aceptado,
  pendiente,
}
