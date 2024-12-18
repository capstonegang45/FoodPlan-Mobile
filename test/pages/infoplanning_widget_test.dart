import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/detail_planning.dart';

void main() {
  testWidgets('InformasiRencana displays information correctly',
      (WidgetTester tester) async {
    final informasi = [
      'Deskripsi Test',
      'Mudah',
      '30 Menit',
      '3 Hari',
      'Jika Anda ingin menurunkan berat badan',
      'Lakukan olahraga setiap hari',
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: InformasiRencana(informasi: informasi)),
    ));

    expect(find.text('Deskripsi:'), findsOneWidget);
    expect(find.text('Deskripsi Test'), findsOneWidget);
    expect(find.text('Tingkat Kesulitan:'), findsOneWidget);
    expect(find.text('Mudah'), findsOneWidget);
  });

  testWidgets('Aktivitas displays activity correctly',
      (WidgetTester tester) async {
    const aktivitas = 'Olahraga setiap hari selama 30 menit';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Aktivitas(aktivitas: aktivitas)),
    ));

    expect(find.text(aktivitas), findsOneWidget);
  });
}
