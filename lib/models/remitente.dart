class Remitente {
  final String nombreApellidos;
  final String email;
  final String movil;

  Remitente({
    required this.nombreApellidos,
    required this.email,
    required this.movil,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre_apellidos': nombreApellidos,
      'email': email,
      'movil': movil,
    };
  }
  factory Remitente.fromMap(Map<String, dynamic> map) {
  return Remitente(
    nombreApellidos: map['nombre_apellidos'],
    email: map['email'],
    movil: map['movil'],
  );
}
}