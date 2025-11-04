import 'package:flutter/material.dart';
import 'ricetta.dart';

class AddRicettaPage extends StatefulWidget {
  final Function(Ricetta) onAggiungi;

  AddRicettaPage({required this.onAggiungi});

  @override
  _AddRicettaPageState createState() => _AddRicettaPageState();
}

class _AddRicettaPageState extends State<AddRicettaPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descrizioneController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 103, 176, 39),
        title: Text("Aggiungi Ricetta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome ricetta"),
            ),
            SizedBox(
        height: 150, // cambia l'altezza come vuoi 👀
        child: TextField(
        controller: descrizioneController,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(labelText: "Descrizione ricetta"),
      ),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: "URL ricetta (opzionale)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 103, 176, 39),
              ),
              onPressed: () {
                final nuovaRicetta = Ricetta(
                  nome: nomeController.text,
                  descrizione: descrizioneController.text,
                  url: urlController.text,
                );

                widget.onAggiungi(nuovaRicetta);
                 Navigator.pop(context, nuovaRicetta); 
              },
              child: Text("Salva"),
            )
          ],
        ),
      ),
    );
  }
}
