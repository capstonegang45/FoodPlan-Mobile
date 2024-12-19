import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/overview.dart'; // Ganti dengan path file aslimu

void main() {
  group('Overview Widgets Test', () {
    testWidgets('Overview1 page test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Overview1(),
        ),
      );

      // Cek apakah gambar muncul
      expect(find.byType(Image), findsOneWidget);

      // Cek judul dan deskripsi
      expect(find.text('Welcome to\nFOODPLAN'), findsOneWidget);
      expect(
          find.text(
              'Saatnya menjaga kesehatan dengan pola makan yang seimbang. Mulailah perjalanan diet sehatmu sekarang!'),
          findsOneWidget);

      // Cek tombol "LEWATI" dan "LANJUT"
      expect(find.text('LEWATI'), findsOneWidget);
      expect(find.text('LANJUT'), findsOneWidget);
    });

    testWidgets('Overview2 page test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Overview2(),
        ),
      );

      // Cek judul dan deskripsi
      expect(find.text('Butuh inspirasi diet sehat?'), findsOneWidget);
      expect(
          find.text(
              'Dapatkan rekomendasi masakan dan rencana diet dari bahan yang kamu punya. Mulai langkah baru hari ini!'),
          findsOneWidget);
    });

    testWidgets('Overview3 page test', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Overview3(),
        ),
      );

      // Cek tombol "MULAI" muncul
      expect(find.text('MULAI'), findsOneWidget);
    });
  });
}
