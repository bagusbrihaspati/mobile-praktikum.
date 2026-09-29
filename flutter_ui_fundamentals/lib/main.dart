import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      title: 'Tahap 12 - Read Local JSON',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StudentJsonScreen(),
    );
  }
}

class StudentJsonScreen extends StatefulWidget {
  const StudentJsonScreen({super.key});

  @override
  State<StudentJsonScreen> createState() => _StudentJsonScreenState();
}

class _StudentJsonScreenState extends State<StudentJsonScreen> {
  // Function pembaca JSON sesuai instruksi modul
  Future<Map<String, dynamic>> loadStudentData() async {
    final jsonString = await rootBundle.loadString('assets/data/student_data.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$studentId - Load Data JSON'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadStudentData(),
        builder: (context, snapshot) {
          // Menampilkan indikator loading saat membaca data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Menampilkan pesan jika terjadi error
          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi Kesalahan: ${snapshot.error}'),
            );
          }

          // Jika data berhasil dimuat
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final student = data['student'] as Map<String, dynamic>;
            final courses = data['courses'] as List<dynamic>;

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Card Informasi Mahasiswa
                Card(
                  color: Colors.deepPurple.shade50,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profil Mahasiswa:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${student['name']} (${student['nim']})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Daftar Mata Kuliah (Courses):',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // List Mata Kuliah dari JSON
                ...courses.map((course) {
                  final String status = course['status'];
                  Color badgeColor;

                  if (status == 'done') {
                    badgeColor = Colors.green;
                  } else if (status == 'active') {
                    badgeColor = Colors.orange;
                  } else {
                    badgeColor = Colors.grey;
                  }

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text(
                          course['code'],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(course['title']),
                      subtitle: Text('${course['credits']} SKS / Credits'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          }

          return const Center(child: Text('Data tidak ditemukan'));
        },
      ),
    );
  }
}