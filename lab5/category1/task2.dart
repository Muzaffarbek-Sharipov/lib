// Task 1.2 – Three-screen chain A -> B -> C
// The system back button does the same as Navigator.pop:
// on B and C it goes one screen back, on A (root) it closes the app.
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: chainStart()));

Widget chainStart() => ChainScreen(
      label: 'A',
      color: Colors.red,
      next: () => ChainScreen(
        label: 'B',
        color: Colors.green,
        next: () => const ChainScreen(label: 'C', color: Colors.blue),
      ),
    );

class ChainScreen extends StatelessWidget {
  final String label;
  final Color color;
  final Widget Function()? next; // null on the last screen (C)

  const ChainScreen({
    super.key,
    required this.label,
    required this.color,
    this.next,
  });

  @override
  Widget build(BuildContext context) {
    final nextBuilder = next;
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen $label'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: nextBuilder != null
            ? ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => nextBuilder()),
                ),
                child: const Text('Next'),
              )
            : ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
      ),
    );
  }
}
