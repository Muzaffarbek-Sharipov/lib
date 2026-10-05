import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContainersScreen(),
    );
  }
}

class ContainersScreen extends StatelessWidget {
  const ContainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const faqs = [
      {
        'question': 'What is Flutter?',
        'answer':
            'Flutter is an open-source UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      },
      {
        'question': 'What is a widget?',
        'answer':
            'A widget is the basic building block of a Flutter user interface. Everything on screen is a widget.',
      },
      {
        'question': 'What is the difference between StatelessWidget and StatefulWidget?',
        'answer':
            'A StatelessWidget never changes once built, while a StatefulWidget keeps state that can change and trigger a rebuild with setState.',
      },
      {
        'question': 'What is hot reload?',
        'answer':
            'Hot reload injects updated code into the running app instantly while preserving its current state.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Structural Containers')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.info, size: 40, color: Colors.blue),
              title: const Text(
                'Information Card',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Group related content using elevation'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Action pressed')),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'FAQ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...faqs.map((faq) {
            return Card(
              child: ExpansionTile(
                title: Text(faq['question']!),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedAlignment: Alignment.centerLeft,
                children: [Text(faq['answer']!)],
              ),
            );
          }),
        ],
      ),
    );
  }
}