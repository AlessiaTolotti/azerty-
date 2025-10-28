import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ColorChangerPage(),
    );
  }
}


class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key});
  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  Color _backgroundColor = Colors.white;
  bool switchValue = false;
  
  void _changeColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _changeColor(Colors.red);
                    },
                    child: const Text('Red'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      _changeColor(Colors.green);
                    },
                    child: const Text('Green'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      _changeColor(Colors.blue);
                    },
                    child: const Text('Blue'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Light/Dark'),
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                        if(switchValue == true) {
                          _backgroundColor = Colors.grey;
                        } else {
                          _backgroundColor = Colors.yellow;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Random r = Random();
                  int n = r.nextInt(Colors.primaries.length);
                  setState(() {
                    _backgroundColor = Colors.primaries[n];
                  });
                },
                child: const Text('Random'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
