import 'package:dbtest/clases/Consignatario.dart';
import 'package:dbtest/clases/Escaneo.dart';
import 'package:dbtest/clases/Remitente.dart';

class PaqueteDTO {
  final int idPaquete;
  String hbl;
  String descripcion;
  int cantidadBultos;
  double peso;
  bool verificado;
  bool perdido;
  DateTime fechaScaner;
  final ConsignatarioDTO Consignatario;
  final RemitenteDTO Remitente;
  final EscaneoDTO escaneo;

  PaqueteDTO({
    required this.idPaquete,
    required this.hbl,
    required this.descripcion,
    required this.cantidadBultos,
    required this.peso,
    required this.verificado,
    required this.perdido,
    required this.fechaScaner,
    required this.Consignatario,
    required this.Remitente,
    required this.escaneo,
  });
}

enum Status {
  rechazado,
  aceptado,
  pendiente,
}
