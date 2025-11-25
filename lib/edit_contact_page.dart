import 'package:flutter/material.dart';
import 'persona.dart';

class EditContactPage extends StatefulWidget {
  final Persona? contact;

  const EditContactPage({super.key, this.contact});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  late String _cognome;
  late List<String> _telefoni;

  @override
  void initState() {
    super.initState();
    _nome = widget.contact?.nome ?? '';
    _cognome = widget.contact?.cognome ?? '';
    _telefoni = widget.contact?.telefoni.toList() ?? [''];
  }

//questo metodo (_removePhoneField) lo abbiamo cercato
//non so se va bene (ho provato a farlo con i (ciclo for) ma non andava)
  
  void _removePhoneField(int index) {
    setState(() {
      if (_telefoni.length > 1) {
        _telefoni.removeAt(index);
      }
    });
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      
      final List<String> cleanTelefoni = [];
      for (final telefono in _telefoni) { 
        final telefonoPulito = telefono.trim(); 
        if (telefonoPulito.isNotEmpty) {
          cleanTelefoni.add(telefonoPulito);
        }
      }
      
      if (cleanTelefoni.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aggiungi almeno un numero di telefono.')),
        );
        return;
      }

      final newContact = Persona(
        nome: _nome,
        cognome: _cognome,
        telefoni: cleanTelefoni,
      );
      
      Navigator.pop(context, newContact);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> campiTelefono = [];
    for (int index = 0; index < _telefoni.length; index++) {
      final number = _telefoni[index]; 
      
      campiTelefono.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: number,
                  decoration: InputDecoration(
                    labelText: 'Telefono ${index + 1}', 
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    if (value != null) {
                      _telefoni[index] = value; 
                    }
                  },
                ),
              ),
              if (_telefoni.length > 1)
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () => _removePhoneField(index),
                ),
            ],
          ),
        ),
      );
    } 
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Nuovo Contatto' : 'Modifica Contatto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il nome è obbligatorio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                initialValue: _cognome,
                decoration: const InputDecoration(labelText: 'Cognome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il cognome è obbligatorio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cognome = value!;
                },
              ),
              const SizedBox(height: 20),
              const Text('Numeri di Telefono:', style: TextStyle(fontSize: 16)),
              
              ...campiTelefono, 
              
              const SizedBox(height: 10),
              
              TextButton.icon(
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Aggiungi Numero'),
                onPressed: () {
                  setState(() {
                    _telefoni.add('');
                  });
                },
              ),
              
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text('Salva Contatto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}