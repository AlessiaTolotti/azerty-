import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatore',
      home: const MyHomePage(title: 'Contatore'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }
//
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _doubleCounter() {
    setState(() {
      _counter = _counter * 2;
    });
  }

  void _halveCounter() {
    setState(() {
      _counter = _counter ~/ 2;
    });
  }

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
              'hai premuto qui tutte queste volte:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _doubleCounter,
            tooltip: 'Double',
            child: const Text('x2'),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: _halveCounter,
            tooltip: 'Halve',
            child: const Text('/2'),
          ),
         
        ],
      ),
    );
  }
}