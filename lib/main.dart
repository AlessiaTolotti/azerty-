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
  bool showOnlyCompleted = false;

  List<Todo> get _filtered {
    if(showOnlyCompleted) {
      return _list.where((t) => t.isDone).toList();
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                showOnlyCompleted = !showOnlyCompleted;
              });
            },
            child: Text(showOnlyCompleted ? 'Mostra tutto' : 'Solo completate'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            if(_filtered.isEmpty)
              const Center(child: Text("non c'è niente")),
            for (var i = 0; i < _filtered.length; i++)
              CheckboxListTile(
                value: _filtered[i].isDone,
                title: Text(
                  _filtered[i].title,
                  style: TextStyle(
                    decoration: _filtered[i].isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                onChanged: (value) {
                  if(value == null) return;
                  setState(() {
                    _filtered[i].isDone = value;
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

  void _goToAddTask() async {
    final result = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if(result != null) {
      setState(() {
        _list.add(result);
      });
    }
  }
}
