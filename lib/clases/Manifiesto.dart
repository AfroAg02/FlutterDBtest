import 'package:dbtest/clases/Contenedor.dart';

class ManifiestoDTO {
  int idManifiesto;
  String exportadora;
  DateTime fechaCarga;
  String rutaArchivo;
  String nombreInterno;
  ContenedorDTO contenedor;

  ManifiestoDTO({
    required this.idManifiesto,
    required this.exportadora,
    required this.fechaCarga,
    required this.rutaArchivo,
    required this.contenedor,
    required this.nombreInterno,
  });
}
