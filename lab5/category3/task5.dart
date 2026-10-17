import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CounterHomeScreen()));

class CounterHomeScreen extends StatefulWidget {
  const CounterHomeScreen({super.key});

  @override
  State<CounterHomeScreen> createState() => _CounterHomeScreenState();
}

class _CounterHomeScreenState extends State<CounterHomeScreen> {
  int _value = 0;
  String _info = '';

  Future<void> _edit() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => EditorScreen(initialValue: _value)),
    );
    if (!mounted) return;

    if (result == null) {
      // Back arrow / system back: nothing was returned.
      setState(() => _info = 'Cancelled (result = null), old value kept');
    } else {
      setState(() {
        _value = result;
        _info = 'Saved: $result';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Value: $_value', style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(_info),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _edit, child: const Text('Edit')),
          ],
        ),
      ),
    );
  }
}

class EditorScreen extends StatefulWidget {
  final int initialValue;
  const EditorScreen({super.key, required this.initialValue});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late int _value = widget.initialValue; // local copy

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$_value', style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filled(
                  onPressed: () => setState(() => _value--),
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                IconButton.filled(
                  onPressed: () => setState(() => _value++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _value),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
