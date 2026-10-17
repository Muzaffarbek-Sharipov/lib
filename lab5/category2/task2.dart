import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const messages = '/messages';
  static const about = '/about';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (context) => const HomeScreen(),
      AppRoutes.profile: (context) => const InfoScreen('Profile'),
      AppRoutes.messages: (context) => const InfoScreen('Messages'),
      AppRoutes.about: (context) => const InfoScreen('About'),
    },
  ));
}

class MenuItem {
  final String title;
  final String route;
  final IconData icon;
  const MenuItem(this.title, this.route, this.icon);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const items = [
    MenuItem('Profile', AppRoutes.profile, Icons.person),
    MenuItem('Messages', AppRoutes.messages, Icons.message),
    MenuItem('About', AppRoutes.about, Icons.info),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        children: [
          for (final item in items)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, item.route),
            ),
        ],
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  final String title;
  const InfoScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This is the "$title" screen',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
