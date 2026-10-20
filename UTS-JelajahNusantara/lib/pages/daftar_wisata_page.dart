import 'package:flutter/material.dart';
import '../models/wisata.dart';
import 'detail_wisata_page.dart';

const List<String> daftarKategori = [
  'Semua',
  'Gunung',
  'Pantai',
  'Sejarah',
  'Danau',
  'Alam',
  'Rekreasi',
];

class DaftarWisataPage extends StatefulWidget {
  final String kategori;
  final ValueChanged<String> onKategoriChanged;
  final List<Wisata> daftarFavorit;
  final ValueChanged<Wisata> ubahFavorit;
  final List<Wisata> daftarRencana;
  final ValueChanged<Wisata> ubahRencana;

  const DaftarWisataPage({
    super.key,
    required this.kategori,
    required this.onKategoriChanged,
    required this.daftarFavorit,
    required this.ubahFavorit,
    required this.daftarRencana,
    required this.ubahRencana,
  });

  @override
  State<DaftarWisataPage> createState() => _DaftarWisataPageState();
}

class _DaftarWisataPageState extends State<DaftarWisataPage> {
  final TextEditingController pencarianController =
      TextEditingController();

  String kataKunci = '';

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  List<Wisata> get wisataTersaring {
    return daftarWisata.where((wisata) {
      final cocokKategori = widget.kategori == 'Semua' ||
          wisata.kategori == widget.kategori;

      final cocokPencarian =
          wisata.nama.toLowerCase().contains(kataKunci.toLowerCase()) ||
          wisata.lokasi.toLowerCase().contains(kataKunci.toLowerCase()) ||
          wisata.kategori.toLowerCase().contains(kataKunci.toLowerCase());

      return cocokKategori && cocokPencarian;
    }).toList();
  }

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
        builder: (_) => DetailWisataPage(
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
    final daftar = wisataTersaring;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              'Jelajahi Wisata',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Temukan destinasi menarik di Indonesia.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: pencarianController,
              onChanged: (value) {
                setState(() => kataKunci = value);
              },
              decoration: InputDecoration(
                hintText: 'Cari nama atau lokasi wisata...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: kataKunci.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          pencarianController.clear();
                          setState(() => kataKunci = '');
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: daftarKategori.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final kategori = daftarKategori[index];
                final aktif = widget.kategori == kategori;

                return ChoiceChip(
                  label: Text(kategori),
                  selected: aktif,
                  onSelected: (_) {
                    widget.onKategoriChanged(kategori);
                  },
                  selectedColor: const Color(0xFF315C43),
                  labelStyle: TextStyle(
                    color: aktif ? Colors.white : Colors.black87,
                    fontWeight: aktif
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              '${daftar.length} destinasi ditemukan',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: daftar.isEmpty
                ? const Center(
                    child: Text('Wisata tidak ditemukan.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: daftar.length,
                    itemBuilder: (context, index) {
                      final wisata = daftar[index];
                      final favorit = isFavorit(wisata);
                      final direncanakan = isDirencanakan(wisata);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 14),
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        elevation: 1,
                        child: InkWell(
                          onTap: () => bukaDetail(wisata),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    wisata.gambar,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(
                                      height: 180,
                                      width: double.infinity,
                                      color: const Color(0xFFE4E9E1),
                                      child: const Icon(
                                        Icons.landscape,
                                        size: 60,
                                        color: Color(0xFF315C43),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Material(
                                      color: Colors.white,
                                      shape: const CircleBorder(),
                                      child: IconButton(
                                        tooltip: favorit
                                            ? 'Hapus dari favorit'
                                            : 'Tambah ke favorit',
                                        icon: Icon(
                                          favorit
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favorit
                                              ? Colors.red
                                              : Colors.black87,
                                        ),
                                        onPressed: () {
                                          widget.ubahFavorit(wisata);
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    top: 12,
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        wisata.kategori,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (direncanakan)
                                    Positioned(
                                      left: 12,
                                      bottom: 12,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF176B52),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.event_available,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Masuk Rencana',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            wisata.nama,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 19,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          wisata.rating.toString(),
                                          style: const TextStyle(
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 17,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(wisata.lokasi),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      wisata.hargaTiket,
                                      style: const TextStyle(
                                        color: Color(0xFF315C43),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Lihat detail',
                                          style: TextStyle(
                                            color: Color(0xFF315C43),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 17,
                                          color: Color(0xFF315C43),
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
          ),
        ],
      ),
    );
  }
}