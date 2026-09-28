import 'package:flutter/material.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 11 - Named Routes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Pendaftaran Rute Terpusat (Named Routes)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
      },
    );
  }
}

// ==================== HALAMAN UTAMA (ROUTE: '/') ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _feedbackData = 'Belum ada data balasan';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Pindah ke rute '/detail' menggunakan Named Route
  Future<void> _navigateToDetail() async {
    final result = await Navigator.pushNamed(
      context,
      '/detail',
      arguments: _controller.text.isEmpty
          ? 'Pesan Default dari Named Route'
          : _controller.text,
    );

    if (result != null && mounted) {
      setState(() {
        _feedbackData = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$studentId - Named Routes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Masukkan pesan via Named Route',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.alt_route),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _navigateToDetail,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Buka Halaman Detail (/detail)'),
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Data Kembalian dari Detail Screen:'),
                    const SizedBox(height: 8),
                    Text(
                      _feedbackData,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HALAMAN DETAIL (ROUTE: '/detail') ====================
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menangkap argumen yang dikirim melalui pushNamed
    final String dataReceived =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'Tidak Ada Data';

    return Scaffold(
      appBar: AppBar(
        title: const Text('$studentName - Detail Route'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Argumen yang Diterima via ModalRoute:'),
              const SizedBox(height: 8),
              Text(
                dataReceived,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, 'Sukses diproses oleh $studentName!');
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali (Pop Route)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}