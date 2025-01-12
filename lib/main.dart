import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_plan/pages/chattbot.dart';
import 'package:food_plan/pages/deteksi.dart';
import 'package:food_plan/pages/forgot_password.dart';
import 'package:food_plan/pages/full_resep.dart';
import 'package:food_plan/pages/notifikasi_setting.dart';
import 'package:food_plan/pages/planning.dart';
import 'package:food_plan/pages/profile_setting.dart';
import 'package:food_plan/pages/register.dart';
import 'package:food_plan/pages/validasi.dart';
import 'package:food_plan/provider/chat_provider.dart';
import 'package:food_plan/provider/rencana_providers.dart';
import 'package:food_plan/provider/users_providers.dart';
import 'package:provider/provider.dart';
import '/pages/login.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
import '/pages/splash_screen.dart';
import '/pages/overview.dart';
import '/pages/login_or_register.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';

// Inisialisasi plugin notifikasi lokal
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handler untuk notifikasi yang diterima saat aplikasi berjalan di background
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  tz.initializeTimeZones();
  // Konfigurasi plugin notifikasi lokal
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Konfigurasi Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Minta izin notifikasi
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else {
  }

  // Listener untuk notifikasi saat aplikasi berjalan di background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listener untuk notifikasi saat aplikasi berjalan di foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {

      // Tampilkan notifikasi lokal
      try {
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'food_plan', // ID channel
          'FoodPlan', // Nama channel
          channelDescription: 'Default channel for notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('sound_alarm'),
        );

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(
          0, // ID notifikasi
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
        );
      // ignore: empty_catches
      } catch (e) {
        // ignore: avoid_print
        print('$e');
      }
    }
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RencanaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => const WillPopWrapper(child: SplashScreen()),
        '/overview1': (context) => const WillPopWrapper(child: Overview1()),
        '/overview2': (context) => const WillPopWrapper(child: Overview2()),
        '/overview3': (context) => const WillPopWrapper(child: Overview3()),
        '/loginorregister': (context) => const WillPopWrapper(child: LoginOrRegister()),
        '/login': (context) => const WillPopWrapper(child: LoginScreen()),
        '/register': (context) => const WillPopWrapper(child: RegisterScreen()),
        '/validasi': (context) => const WillPopWrapper(child: ValidasiScreen()),
        '/beranda': (context) => const WillPopWrapper(child: HomePage()),
        '/deteksi': (context) => const WillPopWrapper(child: DeteksiPage()),
        '/rencana': (context) => const WillPopWrapper(child: RencanaPage()),
        '/fullresep': (context) => const WillPopWrapper(child: FullResep()),
        '/lupapassword': (context) => const WillPopWrapper(child: ForgotPasswordPage()),
        '/profile': (context) => const WillPopWrapper(child: ProfileSettingsPage()),
        '/setting-notifikasi': (context) => const WillPopWrapper(child: TimeSettingsPage()),
        '/chatbot': (context) => const WillPopWrapper(child: ChatScreen()),
      },
    );
  }
}

class WillPopWrapper extends StatelessWidget {
  final Widget child;

  const WillPopWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: child,
    );
  }
}