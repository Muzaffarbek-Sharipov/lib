import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RootScreen()));

class BackOrExitButton extends StatelessWidget {
  const BackOrExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return ElevatedButton(
      onPressed: canPop ? () => Navigator.pop(context) : null, // null = disabled
      child: Text(canPop ? 'Back' : 'Nothing to go back to'),
    );
  }
}

/// Root screen: the button is disabled here.
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BackOrExitButton(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PushedScreen()),
              ),
              child: const Text('Open pushed screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pushed screen: the button is enabled and shows "Back".
class PushedScreen extends StatelessWidget {
  const PushedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pushed screen')),
      body: const Center(child: BackOrExitButton()),
    );
  }
}
