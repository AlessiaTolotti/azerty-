import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'color_changer.dart';
import 'brightness_changer.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // I nomi dei provider sono generati automaticamente aggiungendo "Provider"
    final backgroundColor = ref.watch(colorChangerProvider);
    final brightness = ref.watch(brightnessChangerProvider);
    
    final colorNotifier = ref.read(colorChangerProvider.notifier);
    final brightnessNotifier = ref.read(brightnessChangerProvider.notifier);

    final bool isDark = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Color Changer'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tap a button to change the color!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => colorNotifier.changeColor(Colors.red),
                    child: const Text('Red', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => colorNotifier.changeColor(Colors.green),
                    child: const Text('Green', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => colorNotifier.changeColor(Colors.blue),
                    child: const Text('Blue', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Light/Dark'),
                  Switch(
                    value: isDark,
                    onChanged: (value) => brightnessNotifier.toggleBrightness(value),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => colorNotifier.setRandomColor(),
                child: const Text('Random'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}