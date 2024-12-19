import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/deteksi.dart';

void main() {
  testWidgets('DeteksiPage widget test', (WidgetTester tester) async {
    // Build the DeteksiPage widget
    await tester.pumpWidget(const MaterialApp(home: DeteksiPage()));

    // Verify that the initial state is correct
    expect(find.text('Gambar belum dipilih'), findsOneWidget);
    expect(find.text('Deteksi'), findsOneWidget);

    // Tap the camera icon to pick an image
   
    // Tap the Deteksi button
    final deteksiButton = find.text('Deteksi');
    await tester.tap(deteksiButton);
    await tester.pumpAndSettle(); // Wait for any animations to complete

  });
}