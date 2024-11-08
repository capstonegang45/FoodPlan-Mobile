import 'package:flutter/material.dart';
import 'package:food_plan/pages/deteksi.dart';
import 'package:food_plan/pages/planning.dart';
import 'package:food_plan/pages/register.dart';
import 'package:food_plan/pages/validasi.dart';
import '/pages/login.dart';
import '/pages/splash_screen.dart';
import '/pages/overview.dart';
import '/pages/login_or_register.dart';
import 'pages/home_page.dart';

// import '/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => const SplashScreen(),
        '/overview1': (context) => const Overview1(),
        '/overview2': (context) => const Overview2(),
        '/overview3': (context) => const Overview3(),
        '/loginorregister': (context) => const LoginOrRegister(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/validasi': (context) => const ValidasiScreen(),
        '/beranda': (context) => const HomePage(),
        '/deteksi': (context) => const DeteksiPage(),
        '/rencana': (context) => const RencanaPage(),
        // '/detail_rencana': (context) => DetailRencanaPage(),
      },
    );
  }
}
