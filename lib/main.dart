import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_plan/pages/deteksi.dart';
import 'package:food_plan/pages/forgot_password.dart';
import 'package:food_plan/pages/full_resep.dart';
import 'package:food_plan/pages/planning.dart';
import 'package:food_plan/pages/profile_setting.dart';
import 'package:food_plan/pages/register.dart';
import 'package:food_plan/pages/validasi.dart';
import '/pages/login.dart';
import '/pages/splash_screen.dart';
import '/pages/overview.dart';
import '/pages/login_or_register.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/fullresep': (context) => const FullResep(),
        '/lupapassword': (context) => const ForgotPasswordPage(),
        '/profile': (context) => const ProfileSettingsPage(),
      },
    );
  }
}
