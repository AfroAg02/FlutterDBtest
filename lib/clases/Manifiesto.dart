import 'package:dbtest/clases/Contenedor.dart';

class ManifiestoDTO {
  int idManifiesto;
  String exportadora;
  String fechaCarga;
  ContenedorDTO contenedor;

  ManifiestoDTO({
    required this.idManifiesto,
    required this.exportadora,
    required this.fechaCarga,
    required this.contenedor,
  });
}