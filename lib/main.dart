import 'package:dbtest/clases/Manifiesto.dart';
import 'package:dbtest/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Test',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await printDB();
        },
        tooltip: 'Muestra la base de datos por consola',
        child: Text('Imprimir Datos de la Base de Datos'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> printDB() async {
    Future<List<ManifiestoDTO>> man = DatabaseManager.instance.getManifiestos();
    print(man);
  }
  // Future<void> _printDatabaseData() async {
  //   final db = await DatabaseManager.instance.database;

  //   // Obtener datos de la tabla Consignatario
  //   final consignatarios = await db.query('Consignatario');
  //   print('Datos de la tabla Consignatario:');
  //   consignatarios.forEach((consignatario) {
  //     print(consignatario);
  //   });

  //   // Obtener datos de la tabla Contenedor
  //   final contenedores = await db.query('Contenedor');
  //   print('\nDatos de la tabla Contenedor:');
  //   contenedores.forEach((contenedor) {
  //     print(contenedor);
  //   });

  //   // Obtener datos de la tabla Escaneo
  //   final escaneos = await db.query('Escaneo');
  //   print('\nDatos de la tabla Escaneo:');
  //   escaneos.forEach((escaneo) {
  //     print(escaneo);
  //   });

  //   // Obtener datos de la tabla Manifiesto
  //   final manifiestos = await db.query('Manifiesto');
  //   print('\nDatos de la tabla Manifiesto:');
  //   manifiestos.forEach((manifiesto) {
  //     print(manifiesto);
  //   });

  //   // Obtener datos de la tabla Paquete
  //   final paquetes = await db.query('Paquete');
  //   print('\nDatos de la tabla Paquete:');
  //   paquetes.forEach((paquete) {
  //     print(paquete);
  //   });

  //   // Obtener datos de la tabla Remitente
  //   final remitentes = await db.query('Remitente');
  //   print('\nDatos de la tabla Remitente:');
  //   remitentes.forEach((remitente) {
  //     print(remitente);
  //   });
  // }
}
