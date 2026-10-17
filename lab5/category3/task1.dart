import 'package:flutter/material.dart';

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

void main() => runApp(const MaterialApp(home: ProductListScreen()));

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(product: p),
                  ),
                );
              },
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
