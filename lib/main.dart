import 'package:flutter/material.dart';
import 'package:food_plan/pages/deteksi.dart';
import 'package:food_plan/pages/edit_profile.dart';
import 'package:food_plan/pages/forgot_password.dart';
import 'package:food_plan/pages/full_resep.dart';
import 'package:food_plan/pages/planning.dart';
import 'package:food_plan/pages/profile_setting.dart';
import 'package:food_plan/pages/register.dart';
import 'package:food_plan/pages/validasi.dart';
import 'package:food_plan/services/notification_service.dart';
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
    final NotificationService notificationService = NotificationService();

    // Inisialisasi notifikasi dan jadwalkan
    notificationService.init();

    // Jadwalkan notifikasi untuk makan siang dan makan malam
    notificationService.scheduleMealNotification(const TimeOfDay(hour: 8, minute: 0)); // Makan siang jam 12
    notificationService.scheduleMealNotification(const TimeOfDay(hour: 12, minute: 0)); // Makan siang jam 12
    notificationService.scheduleMealNotification(const TimeOfDay(hour: 18, minute: 0));
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
        '/fullresep': (context) => const FullResep(),
        '/lupapassword': (context) => const ForgotPasswordPage(),
        '/editprofile': (context) => const EditProfile(),
        '/profile': (context) => const ProfileSettingsPage(),

        // '/detail_rencana': (context) => DetailRencanaPage(),
      },
    );
  }
}
