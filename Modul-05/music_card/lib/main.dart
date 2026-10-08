import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Card',

      // a. Menggunakan ThemeData.dark()
      theme: ThemeData.dark(),

      home: const MusicPage(),
    );
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // b. AppBar "Sedang memutar" di tengah
      appBar: AppBar(
        title: const Text('Sedang memutar'),
        centerTitle: true,
      ),

      // c. Card ditempatkan di tengah layar
      body: Center(
        child: Card(
          // d. Properti Card
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          // padding diberikan di dalam Card
          child: Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.album,
                  size: 150,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Sempurna',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Alda Fuadiyah',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}