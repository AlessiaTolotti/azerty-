import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider);
    final isLoggedIn = user != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoggedIn ? 'Benvenuto, ${user.username}!' : 'Benvenuto, ospite!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            if (!isLoggedIn)
              ElevatedButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text('Vai al Login'),
              )
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.push('/profile');
                    },
                    child: const Text('Modifica Profilo'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}