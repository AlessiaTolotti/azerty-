import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'persona.dart';
import 'edit_contact_page.dart';

void main() {
  runApp(const ContattiApp());
}

class ContattiApp extends StatelessWidget {
  const ContattiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elenco Contatti',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const ContattiListScreen(title: 'Lista Contatti'),
    );
  }
}

class ContattiListScreen extends StatefulWidget {
  const ContattiListScreen({super.key, required this.title});
  
  final String title;

  @override
  State<ContattiListScreen> createState() => _ContattiListScreenState();
}

class _ContattiListScreenState extends State<ContattiListScreen> {
  final _contacts = <Persona>[
    Persona(
      nome: "Mario",
      cognome: "Rossi",
      telefoni: ["+393331112223"],
    ),
    Persona(
      nome: "Luigi",
      cognome: "Bianchi",
      telefoni: ["+39111222333", "+39333222111"],
    ),
  ];

  Future<void> _makePhoneCall(String phoneNumber, BuildContext currentContext) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    
    final launched = await canLaunchUrl(launchUri);
    
    if (launched) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Impossibile chiamare: $phoneNumber')),
      );
    }
  }

  void _shareContact(Persona persona) {
    Share.share(persona.testoCondivisione);
  }

  void _editContact(Persona? result, int? index) {
    if (result == null) return;
    
    setState(() {
      if (index == null) {
        _contacts.add(result);
      } else {
        _contacts[index] = result;
      }
    });
  }
  
  Future<void> _navigate(Persona? contact, int? index) async {
    final result = await Navigator.push<Persona>(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactPage(contact: contact),
      ),
    );

    _editContact(result, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Color.fromARGB(255, 78, 112, 149)), 
            onPressed: () => _navigate(null, null),
            label: const Text('Aggiungi'),
          ),
          const SizedBox(width: 8), 
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            if (_contacts.isEmpty)
              const Text("Nessun contatto presente"),
            
            for (final (i, persona) in _contacts.indexed)
              ListTile(
                title: Text(persona.nomeCompleto),
                subtitle: Text(persona.telefoni.join(', ')),
                
                onTap: () {
                  _showContactDetails(persona, i);
                },
                
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (persona.telefoni.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.lightBlue),
                        onPressed: () => _makePhoneCall(persona.telefoni.first, context),
                      ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => _shareContact(persona),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
 
    );
  }

  void _showContactDetails(Persona persona, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(persona.nomeCompleto),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Numeri di telefono:"),
              for (var number in persona.telefoni)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(number),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.lightBlue),
                        onPressed: () {
                          Navigator.pop(context);
                          _makePhoneCall(number, context);
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigate(persona, index);
              },
              child: const Text('Modifica'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),
            ),
          ],
        );
      },
    );
  }
}