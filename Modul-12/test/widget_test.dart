import 'package:flutter_test/flutter_test.dart';
import 'package:modul_12/main.dart';

void main() {
  testWidgets('Aplikasi Lokasi Saya tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const LokasiSayaApp());

    expect(find.text('Lokasi Saya'), findsOneWidget);
    expect(find.text('Akses Lokasi GPS'), findsOneWidget);
    expect(find.text('TAMPILKAN LOKASI SAAT INI'), findsOneWidget);
  });
}