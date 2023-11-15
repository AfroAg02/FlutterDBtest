import 'package:dbtest/clases/Paquete.dart';

class ContenedorDTO {
  final int idContenedor;
  String sscc;
  String origen;
  String destino;
  double tamanno;
  List<PaqueteDTO> paquetes;
  final int totalBultos;
  DateTime? fecha;

  ContenedorDTO(
      {required this.idContenedor,
      required this.sscc,
      required this.origen,
      required this.destino,
      required this.tamanno,
      required this.paquetes,
      required this.totalBultos,
      required this.fecha});
}
