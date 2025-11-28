import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authNotifierProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Errore: Nessun utente')));
    }
    final form = FormGroup({
      'username': FormControl<String>(value: user.username, validators: [Validators.required]),
      'email': FormControl<String>(value: user.email, validators: [Validators.required, Validators.email]),
      'emailConfirmation': FormControl<String>(value: '', validators: [Validators.required, Validators.email]),
    }, validators: [
      Validators.mustMatch('email', 'emailConfirmation')
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('Profilo Utente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Modifica i tuoi dati', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              
              ReactiveTextField(
                formControlName: 'username',
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20),
              
              const Divider(),
              const Text('Conferma Email', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),

              
              ReactiveTextField(
                formControlName: 'email',
                decoration: const InputDecoration(labelText: 'Nuova Email'),
              ),
              const SizedBox(height: 10),

              ReactiveTextField(
                formControlName: 'emailConfirmation',
                decoration: const InputDecoration(labelText: 'Ripeti Email'),
                validationMessages: {
                  ValidationMessage.mustMatch: (error) => 'Le email non corrispondono!',
                },
              ),
              
              const SizedBox(height: 30),
              
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () {
                            final newName = form.control('username').value as String;
                            ref.read(authNotifierProvider.notifier).updateUsername(newName);
                            context.pop(); 
                          }
                        : null,
                    child: const Text('Salva Modifiche'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}