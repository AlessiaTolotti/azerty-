import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            spacing: 16,
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Campo obbligatorio',
                  ValidationMessage.email: (error) => 'Email non valida',
                },
              ),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Campo obbligatorio',
                },
              ),
              const SizedBox(height: 30),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return ElevatedButton(
                    onPressed: formGroup.valid
                        ? () {
                            final email = formGroup.control('email').value as String;
                            ref.read(authNotifierProvider.notifier).login(email);
                            context.go('/home');
                          }
                        : null,
                    child: const Text('Accedi'),
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