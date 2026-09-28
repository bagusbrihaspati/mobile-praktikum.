import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 5 - Stateless vs Stateful',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

// 1. STATELESS WIDGET (Tampilan Statis Header Identitas)
class IdentityHeader extends StatelessWidget {
  final String name;
  final String nim;

  const IdentityHeader({
    super.key,
    required this.name,
    required this.nim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.deepOrange.shade50,
      child: Column(
        children: [
          const Text(
            'StatelessWidget (Identitas Tetap)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            '$nim - $name',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}

// 2. STATEFUL WIDGET (Tampilan Dinamis Counter)
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051090 - I Ketut Bagus Brihaspati'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Panggil Stateless Widget
          const IdentityHeader(
            name: 'I Ketut Bagus Brihaspati',
            nim: '2415051090',
          ),
          const Divider(height: 1),
          
          // Bagian Stateful (Dinamis)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'StatefulWidget (Penghitung Angka):',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$_counter',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _resetCounter,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}