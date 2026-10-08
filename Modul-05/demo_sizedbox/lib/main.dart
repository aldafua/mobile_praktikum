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
      title: 'Modul 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // =========================
  // WIDGET KOTAK
  // =========================
  Container kotakUji(Color warna) {
    return Container(
      width: 75,
      height: 75,
      color: warna,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Modul 5'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ==================================================
            // PERCOBAAN 1 - SIZEDBOX
            // ==================================================

            const Text(
              'Percobaan 1 - SizedBox',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  // Kotak amber
                  kotakUji(Colors.amber),

                  // SizedBox sebagai jarak
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),

                  // Kotak hijau menggunakan SizedBox
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: kotakUji(Colors.green),
                  ),

                  // SizedBox sebagai jarak
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),

                  // Kotak biru
                  kotakUji(Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // PERCOBAAN 2 - SPACER
            // ==================================================

            const Text(
              'Percobaan 2 - Spacer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Kotak amber
                  kotakUji(Colors.amber),

                  // Jarak flex 1
                  const Spacer(flex: 1),

                  // Kotak hijau 100 x 100
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: kotakUji(Colors.green),
                  ),

                  // Jarak flex 2
                  const Spacer(flex: 2),

                  // Kotak biru
                  kotakUji(Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // PERCOBAAN 3 - CARD
            // ==================================================

            const Text(
              'Percobaan 3 - Card',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Informasi lokasi
                  const ListTile(
                    leading: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Taman Nasional Bromo Tengger Semeru',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Jawa Timur, Indonesia',
                    ),
                  ),

                  // Tombol Map dan Phone
                  Container(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          child: const Icon(
                            Icons.map,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          child: const Icon(
                            Icons.phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}