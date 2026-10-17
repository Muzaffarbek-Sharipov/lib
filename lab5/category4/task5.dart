import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
      '/rate': (context) => const RateScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const movie = 'Inception';
  int? _rating; // null = not rated yet

  Future<void> _rate() async {
    final rating =
        await Navigator.pushNamed<int>(context, '/rate', arguments: movie);
    if (!mounted) return;
    // Back arrow -> rating == null -> nothing changes.
    if (rating != null) {
      setState(() => _rating = rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _rating == null
                  ? 'Movie: $movie (not rated yet)'
                  : 'Movie: $_rating/5',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _rate, child: const Text('Rate it')),
          ],
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Rate "$movie"')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var star = 1; star <= 5; star++)
              IconButton(
                iconSize: 40,
                color: Colors.amber,
                icon: const Icon(Icons.star),
                tooltip: '$star',
                onPressed: () => Navigator.pop(context, star),
              ),
          ],
        ),
      ),
    );
  }
}
