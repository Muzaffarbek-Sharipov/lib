import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (c) => const LoginScreen(),
      '/home': (c) => const HomeScreen(),
      '/profile': (c) => const ProfileScreen(),
    },
  ));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          // Replace login with home: no way back to login with "back".
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          child: const Text('Sign in'),
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
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/profile'),
          child: const Text('Open profile'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          // (route) => false  means "remove every route below".
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false),
          child: const Text('Log out'),
        ),
      ),
    );
  }
}
