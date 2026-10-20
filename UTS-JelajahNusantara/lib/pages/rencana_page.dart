import 'package:flutter/material.dart';
import '../models/wisata.dart';
import 'detail_wisata_page.dart';

class RencanaPage extends StatelessWidget {
  final List<Wisata> daftarRencana;
  final ValueChanged<Wisata> hapusRencana;
  final ValueChanged<Wisata> ubahFavorit;
  final List<Wisata> daftarFavorit;

  const RencanaPage({
    super.key,
    required this.daftarRencana,
    required this.hapusRencana,
    required this.ubahFavorit,
    required this.daftarFavorit,
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
              'Rencana Perjalanan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${daftarRencana.length} destinasi dalam rencana',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: daftarRencana.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_note,
                            size: 72,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Belum Ada Rencana Perjalanan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Buka detail wisata dan tekan '
                            '"Tambah ke Rencana".',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarRencana.length,
                      itemBuilder: (context, index) {
                        final wisata = daftarRencana[index];
                        final favorit = daftarFavorit.any(
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
                                    isFavorit: favorit,
                                    ubahFavorit: ubahFavorit,
                                    isDirencanakan: true,
                                    ubahRencana: hapusRencana,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 130,
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
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.event_available,
                                              size: 16,
                                              color: hijau,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Masuk rencana',
                                              style: TextStyle(
                                                color: hijau,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Hapus dari rencana',
                                  onPressed: () => hapusRencana(wisata),
                                  icon: const Icon(
                                    Icons.delete_outline,
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