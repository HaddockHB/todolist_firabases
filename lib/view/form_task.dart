import 'package:cloud_firestore/cloud_firestore.dart'; // Importación de Cloud Firestore
import 'package:flutter/material.dart'; // Importación de Flutter Material

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final nameController =
      TextEditingController(); // Controlador para el campo de nombre
  final numberController =
      TextEditingController(); // Controlador para el campo de número

  @override
  void dispose() {
    nameController.dispose(); // Libera los recursos del controlador de nombre
    numberController.dispose(); // Libera los recursos del controlador de número
    print('Dispose'); // Imprime un mensaje cuando se elimina el estado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Task'), // Título de la barra de aplicación
          backgroundColor:
              Colors.lightGreen, // Color de fondo de la barra de aplicación
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name', // Texto de ayuda para el campo de nombre
                  ),
                  controller:
                      nameController, // Asigna el controlador al campo de nombre
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'Number', // Texto de ayuda para el campo de número
                  ),
                  controller:
                      numberController, // Asigna el controlador al campo de número
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    // Crear un nuevo objeto tarea con el nombre y número proporcionados
                    final task = <String, dynamic>{
                      "name": nameController.text,
                      "number": int.parse(numberController.text),
                    };

                    final db =
                        FirebaseFirestore.instance; // Instancia de Firestore

                    db
                        .collection(
                            "finanzas") // Colección de Firestore para guardar las tareas
                        .add(task) // Agrega la tarea a la colección
                        .then((DocumentReference doc) {
                      Navigator.pop(context); // Regresa a la pantalla anterior
                      print(
                          'DocumentSnapshot added with ID: ${doc.id}'); // Imprime el ID del documento agregado
                    });
                  },
                  child: const Text(
                      'Add New Task')), // Texto del botón para agregar una nueva tarea
            ],
          ),
        ));
  }
}
