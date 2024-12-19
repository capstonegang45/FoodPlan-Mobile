import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInHelper {
  static Future<Map<String, dynamic>> signInWithGoogle(
      String backendUrl) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            "705335153334-akppt6gdk3vjkrm72i1j8qutpr2df6fg.apps.googleusercontent.com", // Ganti dengan Client ID yang benar
      );
      // Login ke Firebase menggunakan Google Sign-In
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Login dibatalkan oleh pengguna.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Ambil kredensial untuk Firebase Authentication
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login ke Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Ambil ID Token dari Firebase Authentication
        String? idToken = await user.getIdToken();

        // Simpan ID Token ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', idToken!);

        Map<String, dynamic> requestBody = {
          'idToken': idToken,
        };
        // Kirim ID Token ke backend Flask
        final response = await http.post(
          Uri.parse('$backendUrl/verify-token'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final responseString = utf8.decode(response.bodyBytes);
          final data = jsonDecode(responseString);
          if (data.containsKey('token')) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', data['token']);
          }
          return {'success': true, 'data': data};
        } else {
          final responseString = utf8.decode(response.bodyBytes);
          final error = jsonDecode(responseString);
          throw Exception(error['message'] ?? "Verifikasi token gagal.");
        }
      } else {
        throw Exception("Gagal mendapatkan data pengguna.");
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
