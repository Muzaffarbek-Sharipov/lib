import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StepScreen(step: 1)));

class StepScreen extends StatelessWidget {
  final int step;
  const StepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Step $step')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You are on step $step of 4',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 16),
            if (step < 4)
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => StepScreen(step: step + 1)),
                ),
                child: const Text('Next'),
              )
            else
              ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Finish'),
              ),
          ],
        ),
      ),
    );
  }
}
