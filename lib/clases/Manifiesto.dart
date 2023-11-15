import 'package:dbtest/clases/Contenedor.dart';

class ManifiestoDTO {
  String idManifiesto;
  String exportadora;
  String fechaCarga;
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
