import 'package:flutter/material.dart';
import 'ricetta.dart';
import 'add_ricetta_page.dart';
import 'package:url_launcher/url_launcher.dart';


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
                onTap: () {
                  showDialog(context: context, builder:(context) {
                    return AlertDialog(
                      title: Text(ricetta.nome),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ricetta.descrizione),
                            const SizedBox(height: 20),
                            if (ricetta.url.isNotEmpty)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); 
                                  _openUrl(context, ricetta.url);
                                  print('url: ${ricetta.url}');
                                },
                                child: const Text("Apri link ricetta"),
                              ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Chiudi"),
                        ),
                      ],
                    );
                  });
                },
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
  

    Future<void> _openUrl(BuildContext context, String urlString) async {
  final Uri url = Uri.parse(urlString);

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Impossibile aprire il link")),
    );
  }
}
  }

