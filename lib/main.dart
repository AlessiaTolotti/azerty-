import "package:flutter/material.dart";
import "ricetta.dart"; 
import "add_ricetta_page.dart";
import "package:url_launcher/url_launcher.dart"; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ricette App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
      ),
      home: const RicetteHome(title: "Le mie Ricette"),
    );
  }
}

class RicetteHome extends StatefulWidget {
  const RicetteHome({required this.title, super.key}); 
  final String title;

  @override
  State<RicetteHome> createState() => _RicetteHomeState();
}

class _RicetteHomeState extends State<RicetteHome> {
  final _list = <Ricetta>[ 
    Ricetta(
      nome: "Pasta al Pesto",
      descrizione: "Un classico della cucina ligure.",
      ingredienti: const ["Pasta", "Pesto", "Parmigiano"], 
      steps: const ["Cuoci la pasta", "Aggiungi il pesto", "Mescola e servi"],
      url: "https://ricette.giallozafferano.it/Bavette-al-pesto.html",
    ),
    Ricetta(
      nome: "Insalata Caprese",
      descrizione: "Fresca e veloce da preparare.",
      ingredienti: const ["Pomodori", "Mozzarella", "Basilico", "Olio"],
      steps: const ["Taglia i pomodori", "Aggiungi mozzarella e basilico", "Condisci con olio"],
      url: "https://blog.giallozafferano.it/lebistro/insalata-caprese/",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        
        actions: [],
      ),
      body: Column( 
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _aggiungiRicetta,
              child: const Text("Aggiungi ricetta"),
            ),
          ),
          Expanded( 
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                final ricetta = _list[index];
                return ListTile(
                  title: Text(ricetta.nome),
                  subtitle: Text(ricetta.descrizione),
                  onTap: () {
                    _mostraDettagli(ricetta);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _aggiungiRicetta() async {
    final result = await Navigator.push<Ricetta>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddRicettaPage(),
      ),
    );

    if (result == null) return; 

    setState(() => _list.add(result)); 
    print("ricetta aggiunta: ${result.nome}");
  }

  void _mostraDettagli(Ricetta ricetta) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ricetta.nome),
          content: Column( 
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ricetta.descrizione),
              const SizedBox(height: 10),
              const Text(
                "Ingredienti:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (final ingrediente in ricetta.ingredienti) 
                Text("• $ingrediente"),
              const SizedBox(height: 10),
              const Text(
                "Passaggi:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (final step in ricetta.steps) 
                Text("• $step"),
            ],
          ),
          actions: [
            if (ricetta.url.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _apriUrl(ricetta.url);
                },
                child: const Text("Apri link"),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Chiudi"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _apriUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);

    } else { //messaggio di errore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossibile aprire il link: $url")),
      );
      
    }

  }
}