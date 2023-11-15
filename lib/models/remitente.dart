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
    factory Remitente.fromMap(Map<String, dynamic> map) {
    return Remitente(
      idRemitente: map['id_remitente'],
      nombreApellidos: map['nombre_apellidos'],
      email: map['email'],
      movil: map['movil'],
    );
  }
}