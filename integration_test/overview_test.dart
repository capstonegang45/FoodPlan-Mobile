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

    // Step 6: Pilih MASUK
    // await tester.tap(find.text('MASUK')); // Tap tombol MASUK
    // await tester.pumpAndSettle();

    // // Verifikasi bahwa halaman login ditampilkan
    // expect(find.text('Masuk'), findsOneWidget); // Verifikasi halaman login

    // // Step 7: Setelah login sukses
    // await tester.enterText(
    //     find.byType(TextField).at(0), 'ilhamhattamanggala123@gmail.com');
    // await tester.enterText(find.byType(TextField).at(1), 'ilham123');
    // await tester.tap(find.text('MASUK'));
    
    // await tester.pumpAndSettle();
    // expect(find.text('Login Successful'), findsOneWidget);
    // await tester.tap(find.text('OK')); // Tap tombol MASUK untuk login
    
    // // Step 7: ValidasiScreen - Tunggu validasi screen setelah login
    // await tester.pumpAndSettle();
    // final appBarFinder = find.byType(AppBar);
    // expect(appBarFinder, findsOneWidget);

    // // Check if the AppBar contains the correct title directly
    // expect(find.text('Informasi tambahan'), findsOneWidget);

    // // Alternatively, check if the title is in the AppBar using a custom widget predicate
    // final customAppBarFinder = find.byWidgetPredicate(
    //   (widget) =>
    //       widget is AppBar &&
    //       widget.title is Text &&
    //       (widget.title as Text).data == 'Informasi tambahan',
    // );
    // expect(customAppBarFinder, findsOneWidget);

    // // Step 8: Pilih DAFTAR
    // await tester.tap(find.text('DAFTAR')); // Tap tombol DAFTAR
    // await tester.pumpAndSettle();
    // expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is Text &&
    //           widget.data == 'Daftar' &&
    //           widget.style?.fontSize == 24.0,
    //     ),
    //     findsOneWidget); // Verifikasi halaman register
    // expect(find.text('Daftar terlebih dahulu untuk melanjutkan'),
    //     findsOneWidget); // Verifikasi halaman register
  });
}
