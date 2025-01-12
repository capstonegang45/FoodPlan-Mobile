import 'package:flutter/material.dart';
import 'package:food_plan/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'SplashScreen ke Login/Register',
      (WidgetTester tester) async {
    // 1. Build aplikasi
    await tester.pumpWidget(const app.MyApp());

    // Step 1: SplashScreen
    // Verifikasi keberadaan CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator),
        findsOneWidget); // Indikator loading
    await tester.pumpAndSettle(
        const Duration(seconds: 3)); // Menunggu animasi SplashScreen selesai

    // Step 2: Overview1
    expect(find.text('Welcome to\nFOODPLAN'),
        findsOneWidget); // Pastikan teks sesuai
    await tester.tap(find.text('LANJUT')); // Tap tombol LANJUT
    await tester.pumpAndSettle();

    // Step 3: Overview2
    expect(find.text('Butuh inspirasi diet sehat?'),
        findsOneWidget); // Verifikasi teks Overview2
    await tester.tap(find.text('LANJUT')); // Tap tombol LANJUT
    await tester.pumpAndSettle();

    // Step 4: Overview3
    expect(find.text('Ayo mulai perjalanan diet sehatmu!'),
        findsOneWidget); // Verifikasi teks Overview3
    await tester.tap(find.text('MULAI')); // Tap tombol MULAI
    await tester.pumpAndSettle();

    // Step 5: LoginOrRegister
    expect(
      find.text(
        'Temukan resep sehat, rencana diet, dan saran dari AI kami untuk mencapai tujuan dietmu. Mulai sekarang!',
      ),
      findsOneWidget,
    ); // Verifikasi teks deskripsi pada halaman LoginOrRegister
  });
}
