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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => SplashScreen(),
        '/overview1': (context) => Overview1(),
        '/overview2': (context) => Overview2(),
        '/overview3': (context) => Overview3(),
        '/loginorregister': (context) => LoginOrRegister(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/validasi': (context) => ValidasiScreen(),
        '/beranda': (context) => HomePage(),
        '/deteksi': (context) => DeteksiPage(),
        '/rencana': (context) => RencanaPage(),
        // '/detail_rencana': (context) => DetailRencanaPage(),
      },
    );
  }
}
