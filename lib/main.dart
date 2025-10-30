import 'package:flutter/material.dart';
import 'todo.dart';
import 'add_task_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const MyHomePage(title: 'TODO'),
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
  final _list = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _list.clear();
              });
            },
            label: const Text('Reset All'),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.invert_colors),
            onPressed: () {
              setState(() {
                for (var i = 0; i < _list.length; i++) {
                  _list[i].isDone = !_list[i].isDone;
                }
              });
            },
            label: const Text('Invert All'),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            if (_list.isEmpty)
              const Text("non c'è niente"),
            for (final (i, todo) in _list.indexed)
              CheckboxListTile(
                value: todo.isDone,
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _list[i].isDone = value;
                  });
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToAddTask() async {
    final result = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (result == null) return;
    
    setState(() {
      _list.add(result);
    });
  }
}