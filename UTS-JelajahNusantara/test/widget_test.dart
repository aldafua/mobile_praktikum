
import 'package:flutter_test/flutter_test.dart';
import 'package:wisata_flutter/main.dart';

void main() {
  testWidgets('Aplikasi JelajahNusantara dapat ditampilkan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const JelajahNusantaraApp());

    expect(find.text('JelajahNusantara'), findsOneWidget);
  });
}
