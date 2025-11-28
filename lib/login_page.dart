import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = FormGroup({
      'email': FormControl<String>(validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(validators: [Validators.required]),
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              ReactiveTextField(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 30),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () {
                            final email = form.control('email').value as String;
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