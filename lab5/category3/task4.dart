import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ColorHomeScreen()));

class ColorHomeScreen extends StatefulWidget {
  const ColorHomeScreen({super.key});

  @override
  State<ColorHomeScreen> createState() => _ColorHomeScreenState();
}

class _ColorHomeScreenState extends State<ColorHomeScreen> {
  Color _color = Colors.grey;

  Future<void> _choose() async {
    final c = await Navigator.push<Color>(
      context,
      MaterialPageRoute(builder: (_) => const ColorPickerScreen()),
    );
    // Never use context/setState after an await without this check.
    if (!mounted) return;
    if (c != null) {
      setState(() => _color = c);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 150, height: 150, color: _color),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _choose,
              child: const Text('Choose colour'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  Widget _button(BuildContext context, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(200, 48),
        ),
        onPressed: () => Navigator.pop(context, color), // result goes back
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _button(context, 'Red', Colors.red),
            _button(context, 'Green', Colors.green),
            _button(context, 'Blue', Colors.blue),
          ],
        ),
      ),
    );
  }
}
