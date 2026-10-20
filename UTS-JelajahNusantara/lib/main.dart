import 'package:flutter/material.dart';

import 'models/wisata.dart';
import 'pages/beranda_page.dart';
import 'pages/daftar_wisata_page.dart';
import 'pages/favorit_page.dart';
import 'pages/rencana_page.dart';

void main() {
  runApp(const JelajahNusantaraApp());
}

class JelajahNusantaraApp extends StatelessWidget {
  const JelajahNusantaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JelajahNusantara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B52),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
        fontFamily: 'Roboto',
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int halamanAktif = 0;
  String kategoriAktif = 'Semua';

  final List<Wisata> daftarFavorit = [];
  final List<Wisata> daftarRencana = [];

  void bukaKategori(String kategori) {
    setState(() {
      kategoriAktif = kategori;
      halamanAktif = 1;
    });
  }

  void ubahFavorit(Wisata wisata) {
    setState(() {
      final index = daftarFavorit.indexWhere(
        (item) => item.id == wisata.id,
      );

      if (index >= 0) {
        daftarFavorit.removeAt(index);
      } else {
        daftarFavorit.add(wisata);
      }
    });
  }

  void ubahRencana(Wisata wisata) {
    setState(() {
      final index = daftarRencana.indexWhere(
        (item) => item.id == wisata.id,
      );

      if (index >= 0) {
        daftarRencana.removeAt(index);
      } else {
        daftarRencana.add(wisata);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> halaman = [
      BerandaPage(
        bukaDaftar: () => bukaKategori('Semua'),
        pilihKategori: bukaKategori,
        daftarFavorit: daftarFavorit,
        ubahFavorit: ubahFavorit,
        daftarRencana: daftarRencana,
        ubahRencana: ubahRencana,
      ),
      DaftarWisataPage(
        kategori: kategoriAktif,
        onKategoriChanged: (kategori) {
          setState(() {
            kategoriAktif = kategori;
          });
        },
        daftarFavorit: daftarFavorit,
        ubahFavorit: ubahFavorit,
        daftarRencana: daftarRencana,
        ubahRencana: ubahRencana,
      ),
      FavoritPage(
        daftarFavorit: daftarFavorit,
        ubahFavorit: ubahFavorit,
        daftarRencana: daftarRencana,
        ubahRencana: ubahRencana,
      ),
      RencanaPage(
        daftarRencana: daftarRencana,
        hapusRencana: ubahRencana,
        ubahFavorit: ubahFavorit,
        daftarFavorit: daftarFavorit,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: halamanAktif,
        children: halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: halamanAktif,
        onDestinationSelected: (index) {
          setState(() {
            halamanAktif = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Wisata',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Rencana',
          ),
        ],
      ),
    );
  }
}