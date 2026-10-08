import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? title;
  String? thumbnail;
  String? shortDescription;
  String? description;
  String? genre;
  String? platform;
  String? release;
  String? cover;
  String? publisher;

  Future<void> getGame(String gameId) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://www.freetogame.com/api/game?id=$gameId',
        ),
      );

      if (response.statusCode == 200) {
        final results = jsonDecode(response.body);

        String gameCover = results['thumbnail'] ?? '';

        if (results['screenshots'] != null &&
            results['screenshots'].isNotEmpty) {
          gameCover = results['screenshots'][0]['image'] ?? gameCover;
        }

        setState(() {
          title = results['title'] ?? 'Tidak ada judul';
          thumbnail = results['thumbnail'] ?? '';
          shortDescription =
              results['short_description'] ?? 'Tidak ada deskripsi singkat';
          description =
              results['description'] ?? 'Tidak ada deskripsi';
          genre = results['genre'] ?? 'Tidak ada genre';
          platform = results['platform'] ?? 'Tidak ada platform';
          publisher = results['publisher'] ?? 'Tidak diketahui';
          release = results['release_date'] ?? 'Tidak diketahui';
          cover = gameCover;
        });
      } else {
        throw Exception(
          'Gagal mengambil data game. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    getGame('475');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0081C9),
        foregroundColor: Colors.white,
        title: const Text('Game FreeToGame'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Center(
          child: title == null
              ? const CircularProgressIndicator(
            color: Colors.white,
          )
              : SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Tujuan.routeName,
                  arguments: ScreenArguments(
                    cover ?? '',
                    title ?? '',
                    description ?? '',
                    shortDescription ?? '',
                  ),
                );
              },

              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: const Color(0xFFF4F8FB),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        thumbnail ?? '',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,

                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                          255,
                          0,
                          47,
                          72,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Genre',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(genre ?? ''),

                            const SizedBox(height: 8),

                            Text(
                              'Platform',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(platform ?? ''),
                          ],
                        ),

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Publisher',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(publisher ?? ''),

                            const SizedBox(height: 8),

                            Text(
                              'Release',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(release ?? ''),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF94A29),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Lihat Detail Game',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}