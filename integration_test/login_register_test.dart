import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/login.dart';
import 'package:food_plan/pages/login_or_register.dart';
import 'package:food_plan/pages/register.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Navigasi langsung ke Login/Register',
    (WidgetTester tester) async {
      // Modifikasi initialRoute untuk langsung ke /loginorregister
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/loginorregister',
          routes: {
            '/loginorregister': (context) => const LoginOrRegister(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
          },
        ),
      );

      // Verifikasi halaman LoginOrRegister ditampilkan
      expect(
        find.text(
          'Temukan resep sehat, rencana diet, dan saran dari AI kami untuk mencapai tujuan dietmu. Mulai sekarang!',
        ),
        findsOneWidget,
      );
      // Step 6: Pilih MASUK
      await tester.tap(find.text('MASUK')); // Tap tombol MASUK
      await tester.pumpAndSettle();

      // Verifikasi bahwa halaman login ditampilkan
      expect(find.text('Masuk'), findsOneWidget); // Verifikasi halaman login

      expect(find.byType(BackButton), findsOneWidget);
// Tap tombol kembali
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Step 8: Pilih DAFTAR
      await tester.tap(find.text('DAFTAR')); // Tap tombol DAFTAR
      await tester.pumpAndSettle();
      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == 'Daftar' &&
                widget.style?.fontSize == 24.0,
          ),
          findsOneWidget); // Verifikasi halaman register
      expect(find.text('Daftar terlebih dahulu untuk melanjutkan'),
          findsOneWidget); // Verifikasi halaman register
    },
  );
}
