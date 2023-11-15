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
    factory Paquete.fromMap(Map<String, dynamic> map) {
    return Paquete(
      idPaquete: map['id_paquete'],
      hbl: map['hbl'],
      descripcion: map['descripcion'],
      cantidadBultos: map['cantidad_bultos'],
      peso: map['peso'],
      verificado: map['verificado'] == 1,
      perdido: map['perdido'] == 1,
      fechaScaner: DateTime.parse(map['fecha_scaner']),
      idContenedor: map['id_contenedor'],
      idConsignatario: map['id_consignatario'],
      idRemitente: map['id_remitente'],
    );
  }
}
