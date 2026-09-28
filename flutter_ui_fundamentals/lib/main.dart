import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 2 - Dasar Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IdentityPage(),
    );
  }
}

class IdentityPage extends StatelessWidget {
  const IdentityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051090 - I Ketut Bagus Brihaspati'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Identitas Mahasiswa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'NIM : 2415051090',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nama : I Ketut Bagus Brihaspati',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}