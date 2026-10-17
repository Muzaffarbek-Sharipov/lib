import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;
  const User({required this.name, required this.age, required this.city});
}

const users = [
  User(name: 'Aziz', age: 21, city: 'Tashkent'),
  User(name: 'Madina', age: 19, city: 'Samarkand'),
  User(name: 'Jasur', age: 23, city: 'Bukhara'),
  User(name: 'Dilnoza', age: 20, city: 'Khiva'),
];

void main() {
  runApp(MaterialApp(
    // No `routes:` table here.
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => const UserListScreen(),
          );
        case '/profile':
          final args = settings.arguments;
          if (args is User) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ProfileScreen(user: args),
            );
          }
          // Wrong or missing argument -> readable error screen.
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen('/profile needs a User argument'),
          );
      }
      return null; // unknown name -> onUnknownRoute below
    },
    onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (_) => ErrorScreen('Unknown route: ${settings.name}'),
    ),
  ));
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users (onGenerateRoute)')),
      body: ListView(
        children: [
          for (final u in users)
            ListTile(
              leading: CircleAvatar(child: Text(u.name[0])),
              title: Text(u.name),
              subtitle: Text('${u.age} years, ${u.city}'),
              onTap: () =>
                  Navigator.pushNamed(context, '/profile', arguments: u),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Open /profile WITHOUT argument'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(user.name[0], style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(height: 16),
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 22)),
            Text('Age: ${user.age}', style: const TextStyle(fontSize: 22)),
            Text('City: ${user.city}', style: const TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message, style: const TextStyle(fontSize: 18))),
    );
  }
}
