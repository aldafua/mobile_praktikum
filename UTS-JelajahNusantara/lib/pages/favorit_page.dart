import 'package:flutter/material.dart';
import '../models/wisata.dart';
import 'detail_wisata_page.dart';

class FavoritPage extends StatelessWidget {
  final List<Wisata> daftarFavorit;
  final ValueChanged<Wisata> ubahFavorit;
  final List<Wisata> daftarRencana;
  final ValueChanged<Wisata> ubahRencana;

  const FavoritPage({
    super.key,
    required this.daftarFavorit,
    required this.ubahFavorit,
    required this.daftarRencana,
    required this.ubahRencana,
  });

  @override
  Widget build(BuildContext context) {
    const hijau = Color(0xFF176B52);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wisata Favorit',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${daftarFavorit.length} destinasi tersimpan',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: daftarFavorit.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 72,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Belum Ada Wisata Favorit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tambahkan wisata melalui ikon hati.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarFavorit.length,
                      itemBuilder: (context, index) {
                        final wisata = daftarFavorit[index];
                        final direncanakan = daftarRencana.any(
                          (item) => item.id == wisata.id,
                        );

                        return Card(
                          margin: const EdgeInsets.only(bottom: 14),
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailWisataPage(
                                    wisata: wisata,
                                    isFavorit: true,
                                    ubahFavorit: ubahFavorit,
                                    isDirencanakan: direncanakan,
                                    ubahRencana: ubahRencana,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 125,
                                  child: Image.asset(
                                    wisata.gambar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        color: const Color(0xFFE4E9E1),
                                        child: const Icon(
                                          Icons.landscape,
                                          size: 42,
                                          color: hijau,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          wisata.nama,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          wisata.lokasi,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          wisata.kategori,
                                          style: const TextStyle(
                                            color: hijau,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (direncanakan)
                                          const Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Sudah masuk rencana',
                                              style: TextStyle(
                                                color: hijau,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Hapus dari favorit',
                                  onPressed: () => ubahFavorit(wisata),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}