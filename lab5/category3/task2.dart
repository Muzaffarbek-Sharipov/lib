import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: InputScreen()));

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter your name')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        GreetingScreen(name: name.isEmpty ? 'stranger' : name),
                  ),
                );
              },
              child: const Text('Greet'),
            ),
          ],
        ),
      ),
    );
  }
}

class GreetingScreen extends StatelessWidget {
  final String name;
  const GreetingScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Greeting')),
      body: Center(
        child: Text('Hello, $name!', style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
