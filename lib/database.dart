import 'package:dbtest/clases/Consignatario.dart';
import 'package:dbtest/clases/Contenedor.dart';
import 'package:dbtest/clases/Escaneo.dart';
import 'package:dbtest/clases/Manifiesto.dart';
import 'package:dbtest/clases/Paquete.dart';
import 'package:dbtest/clases/Remitente.dart';

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
    String path = await getDatabasesPath();
    print(path);
    return await openDatabase(
      join(await path, 'pktea_db'),
      version: 1,
      onCreate: (db, version) async {
        // Crea las tablas al inicializar la base de datos.
        _createTables(db);
        crearYInsertarDatos();
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

  Future<List<ManifiestoDTO>> getManifiestos() async {
    Database db = await instance.database;
    List<Map> res = await db.rawQuery("""
 SELECT 
   M.id_manifiesto,
   M.fecha_carga,
   M.ruta_archivo,
   M.nombre_interno,
   M.exportadora,
   C.id_contenedor,
   C.sscc,
   C.origen,
   C.destino,
   C.tamanno,
   C.total_bultos,
   C.fecha,
   P.id_paquete,
   P.hbl,
   P.descripcion,
   P.cantidad_bultos,
   P.peso,
   P.verificado,
   P.perdido,
   P.fecha_scaner,
   R.nombre_apellidos AS nombre_remitente,
   R.email AS email_remitente,
   R.movil AS movil_remitente,
   R.id_remitente, 
   CN.nombre_apellido AS nombre_consignatario,
   CN.carnet,
   CN.pasaporte,
   CN.direccion,
   CN.municipio,
   CN.provincia,
   CN.telefono,
   CN.movil,
   CN.id_consignatario,
   E.id_escaneo,
   E.descripcion as descripcionE,
   E.fecha AS fechaE,
   E.estado
 FROM Manifiesto M
 JOIN Contenedor C ON M.id_manifiesto = C.id_manifiesto
 JOIN Paquete P ON C.id_contenedor = P.id_contenedor
 JOIN Remitente R ON P.id_remitente = R.id_remitente
 JOIN Consignatario CN ON P.id_consignatario = CN.id_consignatario
 JOIN Escaneo E ON P.id_paquete = E.id_paquete
 """);
    if (res.isEmpty) {
      throw Exception('Error: No existen manifiestos en la base de datos');
    }
    // Extraer los detalles del paquete de cada mapa en res
    List<Map> manifiestos = res
        .map((item) => {
              'id_manifiesto': item['id_manifiesto'],
              'fecha_carga': item['fecha_carga'],
              'ruta_archivo': item['ruta_archivo'],
              'nombre_interno': item['nombre_interno'],
              'exportadora': item['exportadora'],
              'id_contenedor': item['id_contenedor'],
              'sscc': item['sscc'],
              'origen': item['origen'],
              'destino': item['destino'],
              'tamanno': item['tamanno'],
              'total_bultos': item['total_bultos'],
              'fecha': item['fecha'],
              'id_paquete': item['id_paquete'],
              'hbl': item['hbl'],
              'descripcion': item['descripcion'],
              'cantidad_bultos': item['cantidad_bultos'],
              'peso': item['peso'],
              'verificado': item['verificado'],
              'perdido': item['perdido'],
              'fecha_scaner': item['fecha_scaner'],
              'nombre_remitente': item['nombre_remitente'],
              'email_remitente': item['email_remitente'],
              'movil_remitente': item['movil_remitente'],
              'id_remitente': item['id_remitente'],
              'nombre_consignatario': item['nombre_consignatario'],
              'carnet': item['carnet'],
              'pasaporte': item['pasaporte'],
              'direccion': item['direccion'],
              'municipio': item['municipio'],
              'provincia': item['provincia'],
              'telefono': item['telefono'],
              'movil': item['movil'],
              'id_consignatario': item['id_consignatario'],
              'id_escaneo': item['id_escaneo'],
              'descripcionE': item['descripcionE'],
              'fechaE': item['fechaE'],
              'estado': item['estado']
            })
        .toList();

    List<ManifiestoDTO> manifiestosDTO = [];
    List<PaqueteDTO> paquetesDTO = [];
    String idManifiesto_aux = "null";
    bool completed = false;
    int manifiestos_length = manifiestos.length - 1;

    for (int i = 0; i < manifiestos_length; i++) {
      //Recorrer las lista de manifiestos
      Map manifiesto = manifiestos.elementAt(i);
      if (i + 1 != manifiestos_length) {
        idManifiesto_aux = manifiestos.elementAt(i + 1)[
            'id_manifiesto']; //Guardar el id del siguiente manifiesto para guardar sus respectivos paquetes
      }
      //Analizar paquete
      paquetesDTO.add(PaqueteDTO(
          idPaquete: manifiesto['id_paquete'],
          hbl: manifiesto['hbl'],
          descripcion: manifiesto['descripcion'],
          cantidadBultos: manifiesto['cantidad_bultos'],
          peso: manifiesto['peso'],
          verificado: manifiesto['verificado'],
          perdido: manifiesto['perdido'],
          fechaScaner: manifiesto['fecha_scaner'],
          Consignatario: ConsignatarioDTO(
              //Consignatario
              idConsignatario: manifiesto['id_consignatario'],
              nombreApellido: manifiesto['nombre_consignatario'],
              carnet: manifiesto['carnet'],
              pasaporte: manifiesto['pasaporte'],
              direccion: manifiesto['direccion'],
              municipio: manifiesto['municipio'],
              provincia: manifiesto['provincia'],
              telefono: manifiesto['telefono'],
              movil: manifiesto['movil']),
          Remitente: RemitenteDTO(
              //Remitente
              idRemitente: manifiesto['id_remitente'],
              nombreApellidos: manifiesto['nombre_remitente'],
              email: manifiesto['email_remitente'],
              movil: manifiesto['movil_remitente']),
          escaneo: EscaneoDTO(
              //Escaneo
              idEscaneo: manifiesto['id_escaneo'],
              descripcion: manifiesto['descripcionE'],
              fecha: manifiesto['fechaE'],
              estado: manifiesto['estado'])));
      //Comprbar si ya se analizaron todos los paquetes de un manifiesto
      if (manifiesto['id_manifiesto'].toString().compareTo(idManifiesto_aux) !=
          0) completed = true;

      //Guardar manifiesto en caso de cambiar a otro
      if (completed) {
        manifiestosDTO.add(ManifiestoDTO(
            idManifiesto: manifiesto['id_manifiesto'],
            exportadora: manifiesto['exportadora'],
            fechaCarga: manifiesto['fecha_carga'],
            rutaArchivo: manifiesto['ruta_archivo'],
            contenedor: ContenedorDTO(
                idContenedor: manifiesto['id_contenedor'],
                sscc: manifiesto['sscc'],
                origen: manifiesto['origen'],
                destino: manifiesto['destino'],
                tamanno: manifiesto['tamanno'],
                paquetes: paquetesDTO,
                totalBultos: manifiesto['total_bultos'],
                fecha: manifiesto['fecha']),
            nombreInterno: manifiesto['nombre_interno']));

        paquetesDTO.clear();
      }
    }
    return manifiestosDTO;
  }

  Future<Paquete> getPaquetePorHBL(String hbl) async {
    Database db = await instance.database;

    // Ejecuta la consulta SQL
    List<Map<String, dynamic>> res = await db.query(
      'Paquete',
      where: 'hbl = ?',
      whereArgs: [hbl],
    );

    // Asegúrate de que la consulta devolvió al menos un resultado
    if (res.isEmpty) {
      throw Exception('No se encontró ningún paquete con el HBL: $hbl');
    }

    // Convierte el primer resultado en un PaqueteDTO
    Paquete paquete = Paquete.fromMap(res.first);

    return paquete;
  }

  Future<int> insertConsignatario(Consignatario consignatario) async {
    final db = await instance.database;
    int id = await db.insert(
      'Consignatario',
      consignatario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertContenedor(Contenedor contenedor) async {
    final db = await instance.database;
    int id = await db.insert(
      'Contenedor',
      contenedor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertEscaneo(Escaneo escaneo) async {
    final db = await instance.database;
    int id = await db.insert(
      'Escaneo',
      escaneo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertManifiesto(Manifiesto manifiesto) async {
    final db = await instance.database;
    int id = await db.insert(
      'Manifiesto',
      manifiesto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertRemitente(Remitente remitente) async {
    final db = await instance.database;
    int id = await db.insert(
      'Remitente',
      remitente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<void> insertPaquete(Paquete paquete) async {
    final db = await instance.database;
    int id = await db.insert(
      'Paquete',
      paquete.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void crearYInsertarDatos() async {
    // Crear dos manifiestos
    for (int i = 1; i <= 2; i++) {
      Manifiesto manifiesto = Manifiesto(
        idManifiesto: i,
        fechaCarga: DateTime.now(),
        rutaArchivo: 'rutaArchivo$i',
        nombreInterno: 'nombreInterno$i',
        exportadora: 'exportadora$i',
      );
      await insertManifiesto(manifiesto);

      // Crear un contenedor para cada manifiesto
      Contenedor contenedor = Contenedor(
        idContenedor: i,
        sscc: 'sscc$i',
        origen: 'origen$i',
        destino: 'destino$i',
        tamanno: 100.0,
        totalBultos: 10,
        fecha: DateTime.now(),
        idManifiesto: i,
      );
      await insertContenedor(contenedor);

      // Crear 10 paquetes para cada contenedor
      for (int j = 1; j <= 10; j++) {
        Consignatario consignatario = Consignatario(
          idConsignatario: j,
          nombreApellido: 'nombreApellido$j',
          carnet: 'carnet$j',
          pasaporte: 'pasaporte$j',
          direccion: 'direccion$j',
          municipio: 'municipio$j',
          provincia: 'provincia$j',
          telefono: 'telefono$j',
          movil: 'movil$j',
        );
        await insertConsignatario(consignatario);

        Remitente remitente = Remitente(
          idRemitente: j,
          nombreApellidos: 'nombreApellidos$j',
          email: 'email$j',
          movil: 'movil$j',
        );
        await insertRemitente(remitente);

        Escaneo escaneo = Escaneo(
          idEscaneo: j,
          descripcion: 'descripcion$j',
          fecha: DateTime.now(),
          estado: 'estado$j',
          idPaquete: j,
        );
        await insertEscaneo(escaneo);

        Paquete paquete = Paquete(
          idPaquete: j,
          hbl: 'hbl$j',
          descripcion: 'descripcion$j',
          cantidadBultos: 10,
          peso: 200.0,
          verificado: true,
          perdido: false,
          fechaScaner: DateTime.now(),
          idContenedor: i,
          idConsignatario: j,
          idRemitente: j,
        );
        await insertPaquete(paquete);
      }
    }
  }
}

// Future<ManifiestoDTO> getManifiestoDTO(int id) async {
//   Manifiesto manifiesto = await _getManifiesto(id);
//   Consignatario consignatario = await _getConsignatario(id);
//   Contenedor contenedor = await _getContenedor(id);
//   Escaneo escaneo = await _getEscaneo(id);
//   Paquete paquete = await _getEscaneo(id);
//   Remitente remitente = await _getRemitente(id);

//   ManifiestoDTO manifiestoDTO = ManifiestoDTO(idManifiesto: manifiesto.idManifiesto, exportadora:  manifiesto.exportadora, fechaCarga:  manifiesto.fechaCarga, rutaArchivo:  manifiesto.rutaArchivo, contenedor: getContenedorDTO, nombreInterno:  manifiesto.nombreInterno);
//   return
// }

// Future <ContenedorDTO> getContenedorDTO

// Future<Manifiesto> _getManifiesto(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Manifiesto',
//     where: 'id_manifiesto = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Manifiesto.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }

// Future<Contenedor> _getContenedor(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Contenedor',
//     where: 'id_contenedor = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Contenedor.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }

// Future<Paquete> _getPaquete(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Paquete',
//     where: 'id_paquete = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Paquete.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }

// Future<Consignatario> _getConsignatario(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Consignatario',
//     where: 'id_consignatario = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Consignatario.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }
// Future<Remitente> _getRemitente(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Remitente',
//     where: 'id_remitente = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Remitente.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }
// Future<Escaneo> _getEscaneo(int id) async {
//   final db = await instance.database;
//   final maps = await db.query(
//     'Escaneo',
//     where: 'id_escaneo = ?',
//     whereArgs: [id],
//   );

//   if (maps.isNotEmpty) {
//     return Escaneo.fromMap(maps.first);
//   } else {
//     throw Exception('ID $id not found');
//   }
// }

