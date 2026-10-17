import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Product {
  final String name;
  final double price;
  const Product(this.name, this.price);
}

const products = [
  Product('Laptop', 999.0),
  Product('Phone', 599.5),
  Product('Headphones', 79.9),
];

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ProductListScreen()),
    GoRoute(
      path: '/product-details',
      builder: (context, state) {
        final product = state.extra;
        if (product is! Product) {
          return const MissingExtraScreen(); // extra is null after a reload
        }
        return ProductScreen(product: product);
      },
    ),
  ],
);

void main() => runApp(MaterialApp.router(routerConfig: router));

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView(
        children: [
          for (final p in products)
            ListTile(
              title: Text(p.name),
              subtitle: Text('\$${p.price}'),
              onTap: () => context.push('/product-details', extra: p),
            ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Center(
        child: Text('Price: \$${product.price}',
            style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}

class MissingExtraScreen extends StatelessWidget {
  const MissingExtraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No data')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('The product object was lost (extra == null).'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Back to list'),
            ),
          ],
        ),
      ),
    );
  }
}
