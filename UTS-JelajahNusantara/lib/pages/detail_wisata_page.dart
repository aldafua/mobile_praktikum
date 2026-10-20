import 'package:flutter/material.dart';
import '../models/wisata.dart';

class DetailWisataPage extends StatefulWidget {
  final Wisata wisata;
  final bool isFavorit;
  final ValueChanged<Wisata>? ubahFavorit;
  final bool isDirencanakan;
  final ValueChanged<Wisata>? ubahRencana;

  const DetailWisataPage({
    super.key,
    required this.wisata,
    this.isFavorit = false,
    this.ubahFavorit,
    this.isDirencanakan = false,
    this.ubahRencana,
  });

  @override
  State<DetailWisataPage> createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {
  static const hijau = Color(0xFF176B52);
  static const hijauMuda = Color(0xFFE8F5EE);
  static const latar = Color(0xFFF7F9F7);
  static const teksSekunder = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final wisata = widget.wisata;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: latar,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Detail Wisata',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (widget.ubahFavorit != null)
            IconButton(
              tooltip: widget.isFavorit
                  ? 'Hapus dari favorit'
                  : 'Tambah ke favorit',
              onPressed: () => widget.ubahFavorit!(wisata),
              icon: Icon(
                widget.isFavorit
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.isFavorit ? Colors.red : hijau,
                size: 27,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto utama destinasi
            Image.asset(
              wisata.gambar,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 250,
                color: hijauMuda,
                child: const Icon(
                  Icons.landscape,
                  size: 80,
                  color: hijau,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0EADF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      wisata.kategori,
                      style: const TextStyle(
                        color: hijau,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Nama wisata
                  Text(
                    wisata.nama,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2933),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Lokasi
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: hijau,
                        size: 23,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          wisata.lokasi,
                          style: const TextStyle(
                            fontSize: 15,
                            color: teksSekunder,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF4B942),
                        size: 27,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${wisata.rating} / 5.0',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Rating pada data aplikasi',
                        style: TextStyle(
                          fontSize: 12,
                          color: teksSekunder,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Deskripsi
                  const Text(
                    'Tentang Destinasi',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    wisata.deskripsi,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Color(0xFF374151),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Informasi tiket
                  _kartuInformasi(
                    ikon: Icons.confirmation_num_outlined,
                    judul: 'Informasi Tiket',
                    isi: wisata.hargaTiket,
                    keterangan:
                        'Periksa harga dan ketentuan terbaru melalui '
                        'pengelola atau sumber resmi destinasi.',
                  ),

                  const SizedBox(height: 14),

                  // Informasi lokasi
                  _kartuInformasi(
                    ikon: Icons.map_outlined,
                    judul: 'Lokasi Destinasi',
                    isi: wisata.lokasi,
                    keterangan:
                        'Gunakan aplikasi peta untuk memeriksa rute '
                        'dan perjalanan menuju lokasi.',
                  ),

                  const SizedBox(height: 14),

                  // Panduan kunjungan
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: hijau,
                            ),
                            SizedBox(width: 9),
                            Text(
                              'Tips Berkunjung',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _BarisTips(
                          teks: 'Periksa cuaca sebelum berangkat.',
                        ),
                        _BarisTips(
                          teks: 'Patuhi aturan dari pengelola wisata.',
                        ),
                        _BarisTips(
                          teks: 'Jaga kebersihan dan lingkungan.',
                        ),
                        _BarisTips(
                          teks: 'Periksa jam buka melalui sumber resmi.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Tombol rencana perjalanan
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: hijau,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: widget.ubahRencana == null
                          ? null
                          : () {
                              widget.ubahRencana!(wisata);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.isDirencanakan
                                        ? '${wisata.nama} dihapus dari rencana.'
                                        : '${wisata.nama} ditambahkan ke rencana.',
                                  ),
                                ),
                              );
                            },
                      icon: Icon(
                        widget.isDirencanakan
                            ? Icons.check_circle_outline
                            : Icons.luggage_outlined,
                      ),
                      label: Text(
                        widget.isDirencanakan
                            ? 'Sudah Masuk Rencana'
                            : 'Tambah ke Rencana',
                      ),
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

  Widget _kartuInformasi({
    required IconData ikon,
    required String judul,
    required String isi,
    required String keterangan,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: hijauMuda,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: hijau, size: 22),
              const SizedBox(width: 9),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isi,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: hijau,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            keterangan,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: teksSekunder,
            ),
          ),
        ],
      ),
    );
  }
}

class _BarisTips extends StatelessWidget {
  final String teks;

  const _BarisTips({required this.teks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF176B52),
            size: 19,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              teks,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
