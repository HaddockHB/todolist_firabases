// Importación de Cloud Firestore
import 'package:cloud_firestore/cloud_firestore.dart';

// Importación de Flutter Material
import 'package:flutter/material.dart';

// Importación de Firebase Core
import 'package:firebase_core/firebase_core.dart';

// Importación de la clase AddNewTaskScreen desde form_task.dart
import 'package:todolist_firabases/view/form_task.dart';

// Importación de las opciones de Firebase
import 'firebase_options.dart';

void main() async {
  // Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecución de la aplicación MyApp
  runApp(const MyApp());
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Título de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), // Definición del esquema de colores
        useMaterial3: true, // Habilitar Material Design 3 (si es compatible)
      ),
      home: const MyHomePage(
          title: 'Flutter Demo Home Page'), // Página principal de la aplicación
    );
  }
}

// Clase para la página principal de la aplicación
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // Constructor

  final String title; // Título de la página

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(); // Crea el estado de la página
}

// Estado de la página principal
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .inversePrimary, // Color de fondo de la barra de aplicación
        title: Text(widget.title), // Título de la barra de aplicación
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("todolist")
              .snapshots(), // Obtención de un stream de datos desde Firestore
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Text(
                  'Cargando datos...'); // Si no hay datos, muestra un mensaje de carga
            return ListView.builder(
                itemCount: snapshot
                    .data?.docs.length, // Número de elementos en la lista
                itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons
                          .task_alt), // Icono a la izquierda del elemento de la lista
                      title: Text(
                          'Número de Tareas ${snapshot.data!.docs[index]['number']}'), // Título del elemento de la lista
                      subtitle: Text(snapshot.data!.docs[index]
                          ['name']), // Subtítulo del elemento de la lista
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla para agregar una nueva tarea
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddNewTaskScreen(), // Utiliza la clase AddNewTaskScreen
            ),
          );
        },
        tooltip: 'Agregar nueva tarea', // Texto de información sobre el botón
        child: const Icon(Icons.add), // Icono del botón
      ),
    );
  }
}
