import 'package:dbtest/clases/Paquete.dart';

class ContenedorDTO {
  String sscc;
  String origen;
  String destino;
  List<PaqueteDTO> paquetes;
  DateTime? fecha;

  ContenedorDTO(
      {required this.sscc,
      required this.origen,
      required this.destino,
      required this.paquetes,
      required this.fecha});
}