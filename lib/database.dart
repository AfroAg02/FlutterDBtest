import 'package:dbtest/clases/Manifiesto.dart';

import 'models/consignatario.dart';
import 'models/contenedor.dart';
import 'models/escaneo.dart';
import 'models/manifiesto.dart';
import 'models/paquete.dart';
import 'models/remitente.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  DatabaseManager._(); // Constructor privado para asegurar una única instancia.
  static final DatabaseManager instance = DatabaseManager._();

  Database? _database;
//Singleton para la instancia de la database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

//Inicializar la database
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'PKTEADB'),
      version: 1,
      onCreate: (db, version) async {
        // Crea las tablas al inicializar la base de datos.
        print("this");
        _createTables(db);
      },
    );
  }

  void _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE Consignatario (
        id_consignatario INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        nombre_apellido varchar(255) NOT NULL,
        carnet varchar(255),
        pasaporte varchar(255),
        direccion varchar(255),
        municipio varchar(255),
        provincia varchar(255),
        telefono varchar(255),
        movil varchar(255)
      )
    ''');

    await db.execute('''
      CREATE TABLE Contenedor (
        id_contenedor INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        sscc varchar(255),
        origen varchar(255),
        destino varchar(255),
        tamanno double(10),
        total_bultos integer(10) DEFAULT 0 NOT NULL,
        fecha timestamp,
        id_manifiesto integer(10) NOT NULL,
        FOREIGN KEY(id_manifiesto) REFERENCES Manifiesto(id_manifiesto)
      )
    ''');

    await db.execute('''
      CREATE TABLE Escaneo (
        id_escaneo INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        descripcion varchar(255),
        fecha timestamp NOT NULL,
        estado varchar(255) NOT NULL,
        id_paquete integer(10) NOT NULL,
        FOREIGN KEY(id_paquete) REFERENCES Paquete(id_paquete)
      )
    ''');

    await db.execute('''
      CREATE TABLE Manifiesto (
        id_manifiesto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        fecha_carga timestamp NOT NULL,
        ruta_archivo varchar(255) NOT NULL,
        nombre_interno varchar(255) NOT NULL,
        exportadora varchar(255)
      )
    ''');

    await db.execute('''
      CREATE TABLE Paquete (
        id_paquete INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        hbl varchar(255) NOT NULL,
        descripcion varchar(255) NOT NULL,
        cantidad_bultos integer(10) NOT NULL,
        peso double(10) NOT NULL,
        verificado blob DEFAULT 'false' NOT NULL,
        perdido blob NOT NULL,
        fecha_scaner timestamp NOT NULL,
        id_contenedor integer(10) NOT NULL,
        id_consignatario integer(10) NOT NULL,
        id_remitente integer(10) NOT NULL,
        FOREIGN KEY(id_contenedor) REFERENCES Contenedor(id_contenedor),
        FOREIGN KEY(id_consignatario) REFERENCES Consignatario(id_consignatario),
        FOREIGN KEY(id_remitente) REFERENCES Remitente(id_remitente)
      )
    ''');

    await db.execute('''
      CREATE TABLE Remitente (
        id_remitente INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        nombre_apellidos varchar(255),
        email varchar(255),
        movil varchar(255)
      )
    ''');
  }



 Future<void> insertConsignatario(Consignatario consignatario) async {
  final db = await instance.database;
  await db.insert(
    'Consignatario',
    consignatario.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<void> insertContenedor(Contenedor contenedor) async {
  final db = await instance.database;
  await db.insert(
    'Contenedor',
    contenedor.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> insertEscaneo(Escaneo escaneo) async {
  final db = await instance.database;
  await db.insert(
    'Escaneo',
    escaneo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<void> insertManifiesto(Manifiesto manifiesto) async {
  final db = await instance.database;
  await db.insert(
    'Manifiesto',
    manifiesto.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<void> insertRemitente(Remitente remitente) async {
  final db = await instance.database;
  await db.insert(
    'Remitente',
    remitente.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<void> insertPaquete(Paquete paquete) async {
  final db = await instance.database;
  await db.insert(
    'Paquete',
    paquete.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

}
