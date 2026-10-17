// Task 4.3 – User profile: User object sent as a route argument
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
    initialRoute: '/',
    routes: {
      '/': (context) => const UserListScreen(),
      '/profile': (context) => const ProfileScreen(),
    },
  ));
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
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
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
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
