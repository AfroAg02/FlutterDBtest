import 'package:dbtest/models/escaneo.dart';

class PaqueteDTO {
  String hbl;
  double peso;
  Status status;
  DateTime? date;
  String description;
  final Escaneo idEscaneo;

  PaqueteDTO({
    required this.hbl,
    required this.peso,
    required this.status,
    this.date,
    required this.description,
    required this.idEscaneo,
  });
}

enum Status {
  rechazado,
  aceptado,
  pendiente,
}
