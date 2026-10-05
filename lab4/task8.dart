import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GalleryScreen(),
    );
  }
}

String imageUrl(int index, int size) {
  return 'https://picsum.photos/seed/photo$index/$size';
}

Widget imageWithFallback(int index, int size, BoxFit fit) {
  return Image.network(
    imageUrl(index, size),
    fit: fit,
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return const Center(child: CircularProgressIndicator());
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: Colors.grey[300],
        child: const Center(child: Icon(Icons.broken_image, size: 40)),
      );
    },
  );
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        children: List.generate(12, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(index: index),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageWithFallback(index, 400, BoxFit.cover),
            ),
          );
        }),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final int index;

  const PreviewScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Photo ${index + 1}'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: imageWithFallback(index, 1000, BoxFit.contain),
        ),
      ),
    );
  }
}