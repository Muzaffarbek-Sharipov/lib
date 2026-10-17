import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/details', builder: (context, state) => const DetailsScreen()),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: router));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details'),
              child: const Text('go (replace stack)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/details'),
              child: const Text('push (add to stack)'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              canPop
                  ? 'Opened with push:\nthere is a screen below.'
                  : 'Opened with go:\nthe stack was replaced, nothing to pop.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // pop() on an empty stack would throw, so guard with canPop().
              onPressed: canPop ? () => context.pop() : null,
              child: const Text('pop'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('go home'),
            ),
          ],
        ),
      ),
    );
  }
}
