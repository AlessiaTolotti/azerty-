import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  late final FormGroup _form;
  String _displayMessage = '';

  @override
  void initState() {
    super.initState();
    // form per nome e saluto
    _form = FormGroup({
      "name": FormControl<String>(
        value: "",
        validators: [RequiredValidator(), MinLengthValidator(3)],
      ),
      "greeting": FormControl<String>(value: ""),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _showGreeting() {
    if (!_form.valid) return;

    final name = _form.control("name").value;
    final greeting = _form.control("greeting").value;

    print('nome: $name, saluto: $greeting');

    setState(() {
      if (greeting == null || greeting.isEmpty) {
        _displayMessage = 'Ciao, $name!';
      } 
      else {
        _displayMessage = '$greeting, $name!';
      }
    });
  }

  void _clearAll() {
    _form.reset();
    setState(() {
      _displayMessage = '';
    });
    print('tutto pulito');
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
          child: ReactiveForm(
            formGroup: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReactiveTextField<String>(
                  formControlName: "name",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'inserisci il tuo nome',
                  ),
                ),
                const SizedBox(height: 16),
                ReactiveTextField<String>(
                  formControlName: "greeting",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'saluto personalizzato',
                    hintText: 'es: Yo, Hey, Buongiorno',
                  ),
                ),
                const SizedBox(height: 40),
                if (_displayMessage.isNotEmpty)
                  Text(
                    _displayMessage,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
              ],
            ),
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
