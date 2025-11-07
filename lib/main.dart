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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 225, 133, 35),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _vaiAggiungiRicetta,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 133, 35),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Aggiungi ricetta',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (_ricette.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Ancora nessuna ricetta."),
                  ),
                for (final ricetta in _ricette)
                  ListTile(
                    title: Text(ricetta.nome),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
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
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _vaiAggiungiRicetta() async {
    final nuovaRicetta = await Navigator.push<Ricetta>(
      context,
      MaterialPageRoute(
        builder: (context) => AddRicettaPage(onAggiungi: (Ricetta p1) {}),
      ),
    );

    if (nuovaRicetta == null) return;

    setState(() {
      _ricette.add(nuovaRicetta);
    });
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossibile aprire il link.")),
      );
    }
  }
}
////////////////////////////////////////////////////////