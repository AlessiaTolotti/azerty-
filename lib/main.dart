import 'package:flutter/material.dart';
import 'ricetta.dart';
import 'add_ricetta_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricette App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: const RicetteHome(title: 'Ricette'),
    );
  }
}

class RicetteHome extends StatefulWidget {
  const RicetteHome({super.key, required this.title});

  final String title;

  @override
  State<RicetteHome> createState() => _RicetteHomeState();
}

class _RicetteHomeState extends State<RicetteHome> {
  final List<Ricetta> _ricette = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            if (_ricette.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("qui non c'è niente"),
              ),
            for (final ricetta in _ricette)
              ListTile(
                title: Text(ricetta.nome),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _vaiAggiungiRicetta,
      ),
    );
  }

  Future<void> _vaiAggiungiRicetta() async {
    final result = await Navigator.push<Ricetta>(
      context,
      MaterialPageRoute(builder: (context) => AddRicettaPage(onAggiungi: (Ricetta p1) {  },)),
    );

    if (result == null) return;

    setState(() {
      _ricette.add(result);
    });
  }
}
