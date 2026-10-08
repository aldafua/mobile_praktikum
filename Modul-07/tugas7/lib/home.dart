import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0087C9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0087C9),
        foregroundColor: Colors.white,
        title: const Text(
          'Ini Halaman Home',
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
                'Banyak aplikasi memiliki beberapa layar untuk '
                    'menampilkan informasi yang berbeda. Contohnya, '
                    'ada layar untuk data identitas pengguna, halaman '
                    'produk, akan muncul layar dengan detail produk '
                    'tersebut.',
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
                    Icons.home,
                    color: Colors.blue,
                    size: 80,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Pertama, kita perlu membuat dua halaman atau "route" '
                    'yang ingin kita tampilkan. Selanjutnya, kita gunakan '
                    'perintah Navigator.push untuk berpindah dari halaman '
                    'pertama ke halaman kedua. Untuk membuat halaman '
                    'kembali dari halaman tersebut, kita bisa kembali '
                    'ke halaman sebelumnya dengan menggunakan '
                    'Navigator.pop(). Seperti menutup halaman kedua '
                    'dan kembali ke halaman pertama.',
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
                    Navigator.pushNamed(context, '/tujuan');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
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
                    'Ke halaman tujuan ›',
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