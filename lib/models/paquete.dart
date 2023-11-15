class Paquete {
  final String hbl;
  final String descripcion;
  final int cantidadBultos;
  final double peso;
  final bool verificado;
  final bool perdido;
  final DateTime fechaScanner;
  final int idContenedor;
  final int idConsignatario;
  final int idRemitente;
  final Status status;

  Paquete({
    required this.hbl,
    required this.descripcion,
    required this.cantidadBultos,
    required this.peso,
    required this.verificado,
    required this.perdido,
    required this.fechaScanner,
    required this.idContenedor,
    required this.idConsignatario,
    required this.idRemitente,
    this.status= Status.pendiente,
  });

  Map<String, Object?> toMap() {
    return {
      'hbl': hbl,
      'descripcion': descripcion,
      'cantidad_bultos': cantidadBultos,
      'peso': peso,
      'verificado': verificado,
      'perdido': perdido,
      'fecha_scaner': fechaScanner.toIso8601String(),
      'id_contenedor': idContenedor,
      'id_consignatario': idConsignatario,
      'id_remitente': idRemitente,
      'status': status,
    };
  }

  factory Paquete.fromMap(Map<String, dynamic> map) {
    return Paquete(
      hbl: map['hbl'],
      descripcion: map['descripcion'],
      cantidadBultos: map['cantidad_bultos'],
      peso: map['peso'],
      verificado: map['verificado'] == 1,
      perdido: map['perdido'] == 1,
      fechaScanner: DateTime.parse(map['fecha_scaner']),
      idContenedor: map['id_contenedor'],
      idConsignatario: map['id_consignatario'],
      idRemitente: map['id_remitente'],
    );
  }
}

enum Status {
  rechazado,
  aceptado,
  pendiente,
}
