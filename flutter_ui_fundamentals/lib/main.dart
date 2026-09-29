import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

// Fungsi pembaca JSON
Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString('assets/data/student_data.json');
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: studentFuture,
          builder: (context, snapshot) {
            // 1. Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Error State
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Gagal memuat data: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            // 3. Data Loaded State dengan Penanganan Null Safety
            final data = snapshot.data!;
            
            final student = (data['student'] as Map<String, dynamic>?) ?? {};
            final summary = (data['summary'] as Map<String, dynamic>?) ?? {
              'total_topics': 10,
              'progress_percentage': '60%'
            };
            
            // Mengambil list dari 'materials' atau 'courses' jika key beda
            final materials = (data['materials'] as List<dynamic>?) ?? 
                              (data['courses'] as List<dynamic>?) ?? 
                              [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Identity Card (NIM & Nama)
                      IdentityCard(
                        nim: student['nim']?.toString() ?? '2415051090',
                        name: student['name']?.toString() ?? 'I Ketut Bagus Brihaspati',
                        courseTitle: student['course_title']?.toString() ?? 'Flutter UI Fundamentals',
                        meeting: student['meeting']?.toString() ?? 'Pertemuan 4',
                      ),
                      const SizedBox(height: 16),

                      // Summary Row (Topik & Progress)
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              title: 'Topik',
                              value: '${summary['total_topics'] ?? 10}',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              title: 'Progress',
                              value: '${summary['progress_percentage'] ?? '60%'}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Judul "Daftar Materi"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Daftar Materi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),

                // List Materi (ListView.builder)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: materials.length,
                    itemBuilder: (context, index) {
                      final item = materials[index] as Map<String, dynamic>;
                      
                      final String title = item['title']?.toString() ?? 'Materi ${index + 1}';
                      
                      // Konversi nilai status dari format lama ke format baru
                      String status = item['status']?.toString() ?? 'Rencana';
                      if (status == 'done') status = 'Selesai';
                      if (status == 'active') status = 'Berjalan';

                      Color statusColor;
                      if (status == 'Selesai') {
                        statusColor = Colors.green.shade700;
                      } else if (status == 'Berjalan') {
                        statusColor = Colors.deepOrange;
                      } else {
                        statusColor = Colors.grey;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Footer
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Data list dimuat dari JSON statik',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// REUSABLE WIDGET 1: IdentityCard
// ==========================================
class IdentityCard extends StatelessWidget {
  final String nim;
  final String name;
  final String courseTitle;
  final String meeting;

  const IdentityCard({
    super.key,
    required this.nim,
    required this.name,
    required this.courseTitle,
    required this.meeting,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Kartu Atas: NIM & Nama
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NIM: $nim',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Nama: $name',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Baris Profil & Pertemuan
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, color: Colors.blue, size: 30),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  meeting,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

// ==========================================
// REUSABLE WIDGET 2: SummaryCard
// ==========================================
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
        ],
      ),
    );
  }
}