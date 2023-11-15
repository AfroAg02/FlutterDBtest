class Paquete {
  final int idPaquete;
  final String hbl;
  final String descripcion;
  final int cantidadBultos;
  final double peso;
  final bool verificado;
  final bool perdido;
  final DateTime fechaScaner;
  final int idContenedor;
  final int idConsignatario;
  final int idRemitente;

  Paquete({
    required this.idPaquete,
    required this.hbl,
    required this.descripcion,
    required this.cantidadBultos,
    required this.peso,
    required this.verificado,
    required this.perdido,
    required this.fechaScaner,
    required this.idContenedor,
    required this.idConsignatario,
    required this.idRemitente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_paquete': idPaquete,
      'hbl': hbl,
      'descripcion': descripcion,
      'cantidad_bultos': cantidadBultos,
      'peso': peso,
      'verificado': verificado ? 1 : 0,
      'perdido': perdido ? 1 : 0,
      'fecha_scaner': fechaScaner.toIso8601String(),
      'id_contenedor': idContenedor,
      'id_consignatario': idConsignatario,
      'id_remitente': idRemitente,
    };
  }
}
