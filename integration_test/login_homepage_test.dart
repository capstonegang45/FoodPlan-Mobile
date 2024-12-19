import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/deteksi.dart';
import 'package:food_plan/pages/home_page.dart';
import 'package:food_plan/pages/login.dart';
import 'package:food_plan/pages/profile_setting.dart';
import 'package:food_plan/pages/validasi.dart';
import 'package:food_plan/widgets/diet_card.dart';
// import 'package:food_plan/widgets/diet_card_small.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Food Plan App Integration Tests', () {
    testWidgets('Integration Tests', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/validasi': (context) => const ValidasiScreen(),
            '/beranda': (context) => const HomePage(),
            '/profile': (context) => const ProfileSettingsPage(),
            '/deteksi': (context) => const DeteksiPage(),
          },
        ),
      );

      await tester.pumpAndSettle();

      // Verifikasi halaman login
      expect(find.text('Masuk'), findsOneWidget);

      // Masukkan email dan password
      await tester.enterText(
          find.byType(TextField).at(0), 'ilhamhattamanggala123@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'ilham123');

      await tester.pumpAndSettle();
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -220));
      await tester.pumpAndSettle();

      // Tekan tombol login
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // Verifikasi dialog berhasil login
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.text('Login Successful'), findsOneWidget);
      await tester.tap(find.text('OK'));

      await tester.pumpAndSettle();
      // Pastikan berada di layar Validasi
      expect(find.text('Informasi tambahan'), findsOneWidget);

      // Pilih jenis diet
      await tester.tap(find.byKey(const Key('JenisDietDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Diet Normal').at(0));
      await tester.pumpAndSettle();

      // Pilih jenis kelamin
      await tester.tap(find.byKey(const Key('JenisKelaminDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Laki-Laki').at(0));
      await tester.pumpAndSettle();

      // Masukkan data tambahan
      await tester.enterText(find.byType(TextFormField).at(0), '25'); // Usia
      await tester.enterText(find.byType(TextFormField).at(1), '170'); // Tinggi
      await tester.enterText(find.byType(TextFormField).at(2), '65'); // Berat
      await tester.enterText(
          find.byType(TextFormField).at(3), 'Tidak ada'); // Riwayat

      await tester.pumpAndSettle();
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tekan tombol lanjut
      await tester.tap(find.text('Lanjut'));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      // Verifikasi navigasi ke homepage
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(DietCard), findsWidgets);

      // Tap pada salah satu DietCard
      await tester.tap(find.byType(DietCard).first);
      await tester.pumpAndSettle();

      // Verifikasi modal resep muncul
      expect(find.byType(RecipeDetailModal), findsOneWidget);
      Navigator.pop(tester.element(find.byType(RecipeDetailModal)));
      await tester.pumpAndSettle();

      // Buka drawer dan navigasi ke Pengaturan Akun
      await tester.tap(find.byKey(const Key('Pengaturan')));
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byKey(const Key('PengaturanAkun')), findsOneWidget);

      await tester.tap(find.byKey(const Key('PengaturanAkun')));
      await tester.pumpAndSettle();

      // Verifikasi halaman profile muncul
      expect(find.byKey(const Key('AvatarProfile')), findsOneWidget);
      await tester.pumpAndSettle();
      // Tap tombol edit
      await tester.tap(find.byKey(const Key('Edit')).at(0));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verifikasi dialog edit muncul
      expect(find.byType(Dialog), findsOneWidget);

      // Pilih jenis diet
      await tester.tap(find.byKey(const Key('DropDownButton')),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      final offset = tester.getTopLeft(find.text('Diet Normal').at(0));
      await tester.tapAt(offset);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Simpan perubahan
      await tester.tap(find.byKey(const Key('Simpan')), warnIfMissed: false);
      await tester.pumpAndSettle();

      Navigator.pop(tester.element(find.byType(Dialog)));
      await tester.pumpAndSettle();

      // Verifikasi perubahan berhasil
      expect(find.text('Diet Normal'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('IconBack')), findsOneWidget);
      await tester.pumpAndSettle();

      // Kembali ke halaman sebelumnya
      await tester.tap(find.byKey(const Key('IconBack')), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(find.byType(CarouselSlider), findsOneWidget);

      await tester.pumpAndSettle();
      // await tester.tap(find.byKey(const Key('DeteksiPage')));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(RawGestureDetector,
          'DETEKSI')); // Nama label sesuai dengan BottomNavigationBarItem
      await tester.pumpAndSettle();
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('FOODPLAN APP'), findsOneWidget);
    });
  });
}
