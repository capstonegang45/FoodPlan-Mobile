import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/overview.dart';

void main() {
  testWidgets('Test navigasi dari Overview1 ke Overview2',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/overview1': (context) => const Overview1(),
          '/overview2': (context) => const Overview2(),
        },
        initialRoute: '/overview1',
      ),
    );

    // Pastikan berada di Overview1
    expect(find.text('Welcome to\nFOODPLAN'), findsOneWidget);

    // Tekan tombol "LANJUT"
    await tester.tap(find.text('LANJUT'));
    await tester.pumpAndSettle();

    // Pastikan navigasi ke Overview2 berhasil
    expect(find.text('Butuh inspirasi diet sehat?'), findsOneWidget);
  });
}
