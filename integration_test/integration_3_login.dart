// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/chattbot.dart';
import 'package:food_plan/pages/home_page.dart';
import 'package:food_plan/pages/login.dart';
import 'package:food_plan/pages/validasi.dart';
import 'package:food_plan/provider/chat_provider.dart';
import 'package:food_plan/provider/rencana_providers.dart';
import 'package:food_plan/provider/users_providers.dart';
import 'package:food_plan/widgets/custom_bottom_nav.dart';
import 'package:food_plan/widgets/diet_card.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Food Plan App Integration Tests', () {
    testWidgets('Integration Tests', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RencanaProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/validasi': (context) => const ValidasiScreen(),
            '/beranda': (context) => const HomePage(),
            '/chatbot': (context) => const ChatScreen(),
          },
        ),
      ));

      await tester.pumpAndSettle();

      // Verifikasi halaman login
      expect(find.text('Masuk'), findsOneWidget);

      // Masukkan email dan password
      await tester.enterText(
          find.byType(TextField).at(0), 'ilhamhattamanggala123@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'Ilham123');

      await tester.pumpAndSettle();
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -220));
      await tester.pumpAndSettle();

      // Tekan tombol login
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle(const Duration(seconds: 7));

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
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(CarouselSlider), findsOneWidget);
      expect(find.byType(DietCard), findsWidgets);

      // Tap pada salah satu DietCard
      await tester.tap(find.byType(DietCard).first);
      await tester.pumpAndSettle();

      // Verifikasi modal resep muncul
      expect(find.byType(RecipeDetailModal), findsOneWidget);
      Navigator.pop(tester.element(find.byType(RecipeDetailModal)));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      expect(find.byType(SingleChildScrollView), findsWidgets);
      await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -300));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(CustomBottomNavigationBar), findsWidgets);
      expect(find.byIcon(Icons.message_rounded), findsWidgets);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.message_rounded));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'Apa itu diet ?');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.send).first);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('diet adalah'), findsWidgets);
      await tester.pumpAndSettle();
    });
  });
}
