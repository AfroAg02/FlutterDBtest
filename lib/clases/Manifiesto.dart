import 'package:dbtest/clases/Contenedor.dart';

class ManifiestoDTO {
  int idManifiesto;
  String exportadora;  //B3
  DateTime fechaCarga;  //B8
  String rutaArchivo; 
  String nombreInterno; //B5
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
