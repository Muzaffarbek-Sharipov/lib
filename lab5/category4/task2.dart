import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/square': (context) => const SquareScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a number')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final n in [1, 2, 3])
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/square', arguments: n),
                  child: Text('$n', style: const TextStyle(fontSize: 24)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SquareScreen extends StatelessWidget {
  const SquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final n = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: const Text('Square')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Number: $n', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text('$n × $n = ${n * n}', style: const TextStyle(fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
