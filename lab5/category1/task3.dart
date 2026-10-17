import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoginScreen()));

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
              child: const Text('Sign in (pushReplacement)'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
              child: const Text('Sign in (normal push) - for comparison'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          Navigator.canPop(context)
              ? 'Opened with push: you can go back to Login'
              : 'Opened with pushReplacement: nothing to go back to',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
