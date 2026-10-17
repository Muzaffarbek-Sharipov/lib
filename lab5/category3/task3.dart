import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;
  const Contact({required this.name, required this.phone, required this.email});
}

const contacts = [
  Contact(name: 'Alice Johnson', phone: '+1 202 555 0101', email: 'alice@example.com'),
  Contact(name: 'Bob Smith', phone: '+1 202 555 0102', email: 'bob@example.com'),
  Contact(name: 'Carol White', phone: '+1 202 555 0103', email: 'carol@example.com'),
  Contact(name: 'David Brown', phone: '+1 202 555 0104', email: 'david@example.com'),
  Contact(name: 'Eve Davis', phone: '+1 202 555 0105', email: 'eve@example.com'),
];

void main() => runApp(const MaterialApp(home: ContactListScreen()));

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView(
        children: [
          for (final c in contacts)
            ListTile(
              leading: CircleAvatar(child: Text(c.name[0])),
              title: Text(c.name),
              subtitle: Text(c.phone),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ContactScreen(contact: c)),
              ),
            ),
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final Contact contact;
  const ContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Text(contact.name[0],
                          style: const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(contact.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 12),
                  Text(contact.phone),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 12),
                  Text(contact.email),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
