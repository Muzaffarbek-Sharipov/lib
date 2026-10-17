import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductScreen(id: id);
      },
    ),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: router));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final i in [1, 2, 3])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => context.push('/product/$i'),
                  child: Text('Product $i'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String id;
  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product #$id')),
      body: Center(
        child: Text('Product #$id', style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
