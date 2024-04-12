import 'package:cloud_firestore/cloud_firestore.dart'; // Importación de Cloud Firestore
import 'package:flutter/material.dart'; // Importación de Flutter Material
import 'package:firebase_core/firebase_core.dart'; // Importación de Firebase Core
import 'package:todolist_firabases/view/form_task.dart';
import 'firebase_options.dart'; // Importación de las opciones de Firebase

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("todolist").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Cargando datos...');
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.task_alt),
                      title: Text(
                          'Número de Tareas ${snapshot.data!.docs[index]['number']}'),
                      subtitle: Text(snapshot.data!.docs[index]['name']),
                    ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        tooltip: 'Agregar nueva tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}



//Luis Felipe Hernandez Buenrostro TI43 2202128