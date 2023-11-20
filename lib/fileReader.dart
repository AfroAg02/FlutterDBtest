import 'package:dbtest/models/contenedor.dart';
import 'package:dbtest/models/manifiesto.dart';
import 'package:dbtest/models/paquete.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel_dart/excel_dart.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:excel_dart/excel_dart.dart';

class FileReader {
  late Manifiesto manifiesto;
  late Contenedor contenedor;
  late List<Paquete> paquetes;

  Future<void> readFile() async {
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    // if no file is picked
    if (pickedFile != null) {
      String extension = path.extension(pickedFile.paths[0]!);
      if (extension.contains('xlsx')) {
        final bytes = pickedFile.files.first.bytes!;
        final excel = Excel.decodeBytes(bytes);
        final table = excel.tables.keys.first;
        final sheet = excel.tables[table];
        int maxCol = sheet?.maxCols ?? 0;
        int maxRow = sheet?.maxRows ?? 0;
        print(maxRow);
        for (int i = 0; i < maxRow; i++) {
          for (int j = 0; j < maxCol; j++) {
            Data cell = _getCell(i, j, sheet) as Data;
            if(cell.value.toString().compareTo('Exportador')==0){
              
            }
          }
        }
      } else if (extension.contains('csv')) {
        print("csv");
      } else if (extension.contains('xlx')) {
        print("xlx");
      }
    }
  }

  Future<Data?> _getCell(int row, int col, Sheet? sheet) async {
    return (sheet
        ?.cell(CellIndex.indexByColumnRow(rowIndex: row, columnIndex: col)));
  }

  Future<Data?> _getCellUp(Data? cell, Sheet sheet) async {
    return _getCell(cell!.rowIndex, cell.colIndex - 1, sheet);
  }

  Future<Data?> _getCellDown(Data? cell, Sheet sheet) async {
    return _getCell(cell!.rowIndex, cell.colIndex + 1, sheet);
  }

  Future<Data?> _getCellRight(Data? cell, Sheet sheet) async {
    return _getCell(cell!.rowIndex + 1, cell.colIndex, sheet);
  }

  Future<Data?> _getCellLeft(Data? cell, Sheet sheet) async {
    return _getCell(cell!.rowIndex - 1, cell.colIndex, sheet);
  }
}
