import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF432F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF432F),
        foregroundColor: Colors.white,
        title: const Text(
          'Ini Halaman Tujuan',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Untuk berpindah ke halaman baru, gunakan metode '
                    'Navigator.push(). Metode push akan menambahkan '
                    'route baru ke dalam tumpukan Route. Route ini '
                    'dapat dibuat secara otomatis menggunakan '
                    'MaterialPageRoute, yang memberikan tampilan '
                    'transisi secara default dengan animasi transisi '
                    'sesuai dengan platform yang digunakan.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              Center(
                child: Container(
                  width: 115,
                  height: 115,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.beach_access,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Untuk menutup halaman kedua dan kembali ke '
                    'halaman pertama, gunakan metode Navigator.pop(). '
                    'Metode pop() akan menghapus Route saat ini dari '
                    'tumpukan Route yang ada di dalam Navigator.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    '‹ Kembali ke home',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}