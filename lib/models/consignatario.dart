class Consignatario {
  final int idConsignatario;
  final String nombreApellido;
  final String carnet;
  final String pasaporte;
  final String direccion;
  final String municipio;
  final String provincia;
  final String telefono;
  final String movil;

  Consignatario({
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

  Map<String, dynamic> toMap() {
    return {
      'id_consignatario': idConsignatario,
      'nombre_apellido': nombreApellido,
      'carnet': carnet,
      'pasaporte': pasaporte,
      'direccion': direccion,
      'municipio': municipio,
      'provincia': provincia,
      'telefono': telefono,
      'movil': movil,
    };
  }
}