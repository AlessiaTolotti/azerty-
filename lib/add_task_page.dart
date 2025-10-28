import 'package:flutter/material.dart';
import 'todo.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String taskText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Task'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'inserisci la task',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                taskText = value;
            
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(taskText.isEmpty) {
            
                  return;
                }
                final newTask = Todo(
                  title: taskText,
                  createdAt: DateTime.now(),
                );
                Navigator.pop(context, newTask);
              },
              child: const Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}
