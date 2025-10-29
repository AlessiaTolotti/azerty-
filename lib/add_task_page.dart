import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'todo.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      "task": FormControl<String>(
        value: "",
        validators: [RequiredValidator(), MinLengthValidator(3)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Task'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: "task",
                decoration: const InputDecoration(
                  hintText: 'inserisci la task',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Per favore inserisci una task',
                  ValidationMessage.minLength: (_) => 'Inserisci almeno 3 caratteri',
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;
    final newTask = Todo(
      title: _form.control("task").value,
      createdAt: DateTime.now(),
    );
    Navigator.pop(context, newTask);
  }
}