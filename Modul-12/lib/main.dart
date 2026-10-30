
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const LokasiSayaApp());
}

class LokasiSayaApp extends StatelessWidget {
  const LokasiSayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lokasi Saya',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF1A237E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: false,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _position;
  String? _kecamatan;
  String? _kota;
  bool _loading = false;
  String? _error;

  final Geocoding _geocoding = Geocoding();

  Future<void> _ambilLokasi() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Memeriksa apakah layanan lokasi aktif.
      final bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception(
          'Layanan lokasi belum aktif. Aktifkan GPS terlebih dahulu.',
        );
      }

      // Memeriksa dan meminta izin lokasi.
      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Izin lokasi belum diberikan.');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen. Aktifkan melalui pengaturan aplikasi.',
        );
      }

      // Mengambil koordinat GPS perangkat.
      final Position posisi = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );

      // Mengubah koordinat menjadi informasi alamat.
      String kecamatan = 'Tidak tersedia';
      String kota = 'Tidak tersedia';

      try {
        final List<Placemark> placemarks =
        await _geocoding.placemarkFromCoordinates(
          posisi.latitude,
          posisi.longitude,
        );

        if (placemarks.isNotEmpty) {
          final Placemark tempat = placemarks.first;

          kecamatan = tempat.subAdministrativeArea?.isNotEmpty == true
              ? tempat.subAdministrativeArea!
              : (tempat.subLocality?.isNotEmpty == true
              ? tempat.subLocality!
              : 'Tidak tersedia');

          kota = tempat.locality?.isNotEmpty == true
              ? tempat.locality!
              : (tempat.administrativeArea?.isNotEmpty == true
              ? tempat.administrativeArea!
              : 'Tidak tersedia');
        }
      } catch (_) {
        // Koordinat tetap ditampilkan jika alamat gagal diperoleh.
      }

      if (!mounted) return;

      setState(() {
        _position = posisi;
        _kecamatan = kecamatan;
        _kota = kota;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _bukaPengaturan() async {
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Saya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: _loading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1A237E),
                    ),
                  )
                      : _error != null
                      ? Column(
                    children: [
                      const Icon(
                        Icons.location_off,
                        color: Colors.red,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      if (_error!.contains('permanen')) ...[
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _bukaPengaturan,
                          child: const Text(
                            'BUKA PENGATURAN APLIKASI',
                          ),
                        ),
                      ],
                    ],
                  )
                      : _position == null
                      ? const Text(
                    'Informasi lokasi akan ditampilkan di sini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  )
                      : Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Lokasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Latitude: ${_position!.latitude}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Longitude: ${_position!.longitude}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Kelurahan/Kecamatan: $_kecamatan',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Kota: $_kota',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _loading ? null : _ambilLokasi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _loading
                      ? 'MENGAMBIL LOKASI...'
                      : 'TAMPILKAN LOKASI SAAT INI',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
