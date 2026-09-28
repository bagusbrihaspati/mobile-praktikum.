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
      title: 'Tahap 10 - Navigasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirstScreen(),
    );
  }
}

// ==================== HALAMAN 1 ====================
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _controller = TextEditingController();
  String _feedbackData = 'Belum ada data balasan';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk push & menunggu balasan (Get Data)
  Future<void> _navigateToSecondScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          dataKirim: _controller.text.isEmpty
              ? 'Pesan Default dari Halaman 1'
              : _controller.text,
        ),
      ),
    );

    // Menerima data kembalian dari Halaman 2
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
        title: const Text('$studentId - Halaman Utama'),
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
                labelText: 'Masukkan pesan yang ingin dikirim',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _navigateToSecondScreen,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Kirim & Pindah Halaman'),
            ),
            const SizedBox(height: 32),
            Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Data Balasan dari Halaman 2:'),
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

// ==================== HALAMAN 2 ====================
class SecondScreen extends StatelessWidget {
  final String dataKirim;

  const SecondScreen({super.key, required this.dataKirim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$studentName - Detail'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Data yang Diterima:'),
              const SizedBox(height: 8),
              Text(
                dataKirim,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // Kembali sambil mengirim data balik (Pop Data)
                  Navigator.pop(context, 'Data berhasil diproses oleh $studentName!');
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali & Kirim Status'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}