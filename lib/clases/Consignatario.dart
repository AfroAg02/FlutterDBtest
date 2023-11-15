class ConsignatarioDTO {
  final int idConsignatario;
  String nombreApellido;
  String carnet;
  String pasaporte;
  String direccion;
  String municipio;
  String provincia;
  String telefono;
  String movil;

  ConsignatarioDTO({
    required this.idConsignatario,
    required this.nombreApellido,
    required this.carnet,
    required this.pasaporte,
    required this.direccion,
    required this.municipio,
    required this.provincia,
    required this.telefono,
    required this.movil,
  });
}
