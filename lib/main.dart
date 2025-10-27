import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Color Changer',
      home: const ColorChangerPage(),
    );
  }
}

class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key});

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  // Stato per il colore di sfondo
  Color _backgroundColor = Colors.white;
  bool _isLightMode = true;

  // Cambia colore manualmente
  void _changeColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  // Toggle Light/Dark mode
  void _toggleMode(bool value) {
    setState(() {
      _isLightMode = value;
      _backgroundColor = _isLightMode ? Colors.yellow : Colors.grey[850]!;
    });
  }

  // Colore casuale
  void _randomizeColor() {
    final random = Random();
    setState(() {
      _backgroundColor =
          Colors.primaries[random.nextInt(Colors.primaries.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Color Changer'),
        backgroundColor: Colors.black87,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tap a button to change the color!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              // Pulsanti Red/Green/Blue
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => _changeColor(Colors.red),
                    child: const Text('Red'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => _changeColor(Colors.green),
                    child: const Text('Green'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => _changeColor(Colors.blue),
                    child: const Text('Blue'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Switch Light/Dark
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dark Mode'),
                  Switch(
                    value: _isLightMode,
                    onChanged: _toggleMode,
                  ),
                  const Text('Light Mode'),
                ],
              ),
              const SizedBox(height: 20),
              // Pulsante Random Color
              ElevatedButton.icon(
                onPressed: _randomizeColor,
                icon: const Icon(Icons.shuffle),
                label: const Text('Random Color'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
