import 'package:flutter/material.dart';
import '../models/wisata.dart';
import 'detail_wisata_page.dart';

class BerandaPage extends StatefulWidget {
  final VoidCallback bukaDaftar;
  final ValueChanged<String> pilihKategori;
  final List<Wisata> daftarFavorit;
  final ValueChanged<Wisata> ubahFavorit;
  final List<Wisata> daftarRencana;
  final ValueChanged<Wisata> ubahRencana;

  const BerandaPage({
    super.key,
    required this.bukaDaftar,
    required this.pilihKategori,
    required this.daftarFavorit,
    required this.ubahFavorit,
    required this.daftarRencana,
    required this.ubahRencana,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final Color hijau = const Color(0xFF176B52);
  final Color krem = const Color(0xFFF7F5EF);

  bool isFavorit(Wisata wisata) {
    return widget.daftarFavorit.any(
      (item) => item.id == wisata.id,
    );
  }

  bool isDirencanakan(Wisata wisata) {
    return widget.daftarRencana.any(
      (item) => item.id == wisata.id,
    );
  }

  void bukaDetail(Wisata wisata) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailWisataPage(
          wisata: wisata,
          isFavorit: isFavorit(wisata),
          ubahFavorit: widget.ubahFavorit,
          isDirencanakan: isDirencanakan(wisata),
          ubahRencana: widget.ubahRencana,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Wisata> rekomendasi = daftarWisata.take(6).toList();

    return Scaffold(
      backgroundColor: krem,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: hijau,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JelajahNusantara',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: hijau,
                          ),
                        ),
                        const Text(
                          'Temukan keindahan Indonesia',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: hijau,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jelajahi Indonesia!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Temukan destinasi wisata menarik dan '
                      'rencanakan petualanganmu berikutnya.',
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      onPressed: widget.bukaDaftar,
                      icon: const Icon(Icons.explore),
                      label: const Text('Jelajahi Wisata'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: hijau,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              const Text(
                'Kategori Wisata',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _kategoriChip('Gunung', Icons.landscape),
                  _kategoriChip('Pantai', Icons.beach_access),
                  _kategoriChip('Sejarah', Icons.account_balance),
                  _kategoriChip('Danau', Icons.water),
                  _kategoriChip('Alam', Icons.park),
                  _kategoriChip('Rekreasi', Icons.attractions),
                ],
              ),
              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Rekomendasi Wisata',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: widget.bukaDaftar,
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: hijau,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (rekomendasi.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Belum ada data wisata.'),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rekomendasi.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final wisata = rekomendasi[index];
                    final favorit = isFavorit(wisata);

                    return InkWell(
                      onTap: () => bukaDetail(wisata),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    wisata.gambar,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        color: const Color(0xFFDCE9E1),
                                        child: Icon(
                                          Icons.landscape,
                                          size: 48,
                                          color: hijau,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Material(
                                      color: Colors.white,
                                      shape: const CircleBorder(),
                                      child: IconButton(
                                        visualDensity:
                                            VisualDensity.compact,
                                        tooltip: favorit
                                            ? 'Hapus dari favorit'
                                            : 'Tambah ke favorit',
                                        onPressed: () {
                                          widget.ubahFavorit(wisata);
                                        },
                                        icon: Icon(
                                          favorit
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favorit
                                              ? Colors.red
                                              : hijau,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(11),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    wisata.nama,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: hijau,
                                      ),
                                      const SizedBox(width: 3),
                                      Expanded(
                                        child: Text(
                                          wisata.lokasi,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange.shade700,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${wisata.rating}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 17,
                                        color: hijau,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kategoriChip(String kategori, IconData ikon) {
    return ActionChip(
      avatar: Icon(
        ikon,
        size: 18,
        color: hijau,
      ),
      label: Text(kategori),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: hijau.withAlpha(50),
      ),
      onPressed: () => widget.pilihKategori(kategori),
    );
  }
}