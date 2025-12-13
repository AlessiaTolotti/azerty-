import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authNotifierProvider);

    form = FormGroup({
      'username': FormControl<String>(
        value: user?.username,
        validators: [
          Validators.required,
        ],
      ),
      'email': FormControl<String>(
        value: user?.email,
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'emailConfirmation': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
    }, validators: [
      Validators.mustMatch('email', 'emailConfirmation'),
    ]);
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Errore: Nessun utente'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo Utente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Modifica i tuoi dati',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ReactiveTextField<String>(
                formControlName: 'username',
                decoration: const InputDecoration(labelText: 'Username'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Campo obbligatorio',
                },
              ),
              const Divider(),
              const Text(
                'Conferma Email',
                style: TextStyle(color: Colors.grey),
              ),
              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: const InputDecoration(labelText: 'Nuova Email'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Campo obbligatorio',
                  ValidationMessage.email: (error) => 'Email non valida',
                },
              ),
              ReactiveTextField<String>(
                formControlName: 'emailConfirmation',
                decoration: const InputDecoration(labelText: 'Ripeti Email'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Campo obbligatorio',
                  ValidationMessage.email: (error) => 'Email non valida',
                  ValidationMessage.mustMatch: (error) => 'Le email non corrispondono!',
                },
              ),
              const SizedBox(height: 10),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return ElevatedButton(
                    onPressed: formGroup.valid
                        ? () {
                            final newName = formGroup.control('username').value as String;
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