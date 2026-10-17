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
      AppRoutes.home: (c) => const DrawerPage(title: 'Home'),
      AppRoutes.profile: (c) => const DrawerPage(title: 'Profile'),
      AppRoutes.messages: (c) => const DrawerPage(title: 'Messages'),
      AppRoutes.about: (c) => const DrawerPage(title: 'About'),
    },
  ));
}

class MenuItem {
  final String title;
  final String route;
  final IconData icon;
  const MenuItem(this.title, this.route, this.icon);
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const items = [
    MenuItem('Home', AppRoutes.home, Icons.home),
    MenuItem('Profile', AppRoutes.profile, Icons.person),
    MenuItem('Messages', AppRoutes.messages, Icons.message),
    MenuItem('About', AppRoutes.about, Icons.info),
  ];

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name;
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
          for (final item in items)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              selected: item.route == current,
              onTap: () {
                Navigator.pop(context); // 1) close the drawer
                if (item.route != current) {
                  // 2) replace the current screen
                  Navigator.pushReplacementNamed(context, item.route);
                }
              },
            ),
        ],
      ),
    );
  }
}

class DrawerPage extends StatelessWidget {
  final String title;
  const DrawerPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('$title section\n(open the drawer to switch)',
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
