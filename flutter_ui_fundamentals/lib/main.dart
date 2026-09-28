import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 7 - Widget UI Dasar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BasicWidgetsPage(),
    );
  }
}

class BasicWidgetsPage extends StatelessWidget {
  const BasicWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2415051090 - I Ketut Bagus Brihaspati'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. CircleAvatar dengan Image Asset (profile.jpg)
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.blue.shade100,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Text Widget
            const Text(
              'I Ketut Bagus Brihaspati',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
              'NIM: 2415051090',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // 3. Card & ListTile Widget
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.blue),
                    title: Text('Program Studi'),
                    subtitle: Text('Pendidikan Teknik Informatika (PTI)'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_city, color: Colors.blue),
                    title: Text('Fakultas'),
                    subtitle: Text('Teknik dan Kejuruan (FTK)'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.account_balance, color: Colors.blue),
                    title: Text('Universitas'),
                    subtitle: Text('Universitas Pendidikan Ganesha'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Button Widgets (ElevatedButton & OutlinedButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tombol Simpan Profil Diklik!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Profil'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tombol Bagikan Profil Diklik!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Bagikan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}