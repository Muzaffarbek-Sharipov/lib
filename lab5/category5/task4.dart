import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open with scale + fade'),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 450),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const DetailsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  );
                  // FadeTransition wraps ScaleTransition; same animation drives both.
                  return FadeTransition(
                    opacity: curved,
                    child: ScaleTransition(
                      scale:
                          Tween<double>(begin: 0.8, end: 1.0).animate(curved),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: const Center(child: Text('I grew and faded in!')),
    );
  }
}
