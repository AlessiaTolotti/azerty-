import "package:flutter/material.dart";
import "ricetta.dart"; 

class AddRicettaPage extends StatefulWidget {
  const AddRicettaPage({super.key});

  @override
  State<AddRicettaPage> createState() => _AddRicettaPageState();
}

class _AddRicettaPageState extends State<AddRicettaPage> {
  final _nomeController = TextEditingController();
  final _descrizioneController = TextEditingController();
  final _urlController = TextEditingController();
  final _ingredientiController = TextEditingController();
  final _stepsController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, 
        title: const Text("Aggiungi Ricetta"),
        foregroundColor: Colors.white,
      ),
     
      body: SingleChildScrollView( 
        child: Padding( 
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome ricetta"),
              ),
              TextField(
                controller: _ingredientiController,
                decoration: const InputDecoration(
                  labelText: "Ingredienti (separati da virgola)",
                ),
              ),
              
              SizedBox( 
                height: 150, 
                child: TextField(
                  controller: _stepsController,
                  decoration: const InputDecoration(
                    labelText: "Procedimento (separati da virgola)",
                  ),
                  maxLines: null,
                  expands: true,
                ),
              ),
              TextField(
                controller: _descrizioneController,
                decoration: const InputDecoration(labelText: "Descrizione ricetta"),
              ),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: "URL ricetta (opzionale)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: _salva,
                child: const Text("Salva"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _salva() {
    final ricetta = Ricetta(
      nome: _nomeController.text,
      descrizione: _descrizioneController.text,
      url: _urlController.text,
      ingredienti: _ingredientiController.text
          .split(",") 
          .map((e) => e.trim()) 
          .where((e) => e.isNotEmpty)
          .toList(),
      steps: _stepsController.text
          .split(",")
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );

    print("salvo ricetta: ${ricetta.nome}");
    Navigator.pop(context, ricetta);
  }
}