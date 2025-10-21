import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greeter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Personal Greeter'),
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _greetingController = TextEditingController();
  String _displayMessage = '';

  void _showGreeting() {
    setState(() {
      final name = _nameController.text;
      final greeting = _greetingController.text;

      if (name.isEmpty) {
        _displayMessage = 'inserisci un nome!';
      } else {
        if (greeting.isEmpty) {
          _displayMessage = 'Ciao, $name!';
        } else {
          _displayMessage = '$greeting, $name!';
        }
      }
    });
  }

  void _clearAll() {
    setState(() {
      _nameController.clear();
      _greetingController.clear();
      _displayMessage = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'inserisci il tuo nome',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _greetingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'saluto personalizzato (opzionale)',
                  hintText: 'es: Yo, Hey, Buongiorno',
                ),
              ),
              SizedBox(height: 40),
              if (_displayMessage.isNotEmpty)
                Text(
                  _displayMessage,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showGreeting,
            tooltip: 'Salutami!',
            child: const Icon(Icons.message),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _clearAll,
            tooltip: 'Pulisci tutto',
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
