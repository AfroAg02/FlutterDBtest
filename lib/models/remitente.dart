class Remitente {
  final int idRemitente;
  final String nombreApellidos;
  final String email;
  final String movil;

  Remitente({
    required this.idRemitente,
    required this.nombreApellidos,
    required this.email,
    required this.movil,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_remitente': idRemitente,
      'nombre_apellidos': nombreApellidos,
      'email': email,
      'movil': movil,
    };
  }
}