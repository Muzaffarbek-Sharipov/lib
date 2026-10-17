import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: 'item',
      path: '/item/:id',
      builder: (context, state) =>
          ItemScreen(id: state.pathParameters['id']!),
    ),
  ],
  errorBuilder: (context, state) =>
      NotFoundScreen(location: state.uri.toString()),
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
              onPressed: () => context.goNamed('settings'),
              child: const Text('Settings'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  context.goNamed('item', pathParameters: {'id': '42'}),
              child: const Text('Item 42'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              // This location does not exist -> errorBuilder is used.
              onPressed: () => context.go('/does-not-exist'),
              child: const Text('Broken link (404)'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('home'),
          child: const Text('Home'),
        ),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  final String id;
  const ItemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item $id')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Item id: $id', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  final String location;
  const NotFoundScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 12),
            Text('Page not found: $location'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
