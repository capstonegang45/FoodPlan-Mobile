import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInHelper {
  static GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
      "705335153334-akppt6gdk3vjkrm72i1j8qutpr2df6fg.apps.googleusercontent.com", // Ganti dengan Client ID yang benar
  );
  static Future<Map<String, dynamic>> signInWithGoogle(
      String backendUrl) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Login dibatalkan oleh pengguna.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          String? idToken = await user.getIdToken();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', idToken!);

          Map<String, dynamic> requestBody = {'idToken': idToken};

          final response = await http.post(
            Uri.parse('$backendUrl/verify-token'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(requestBody),
          );

          if (response.statusCode == 200) {
            final responseString = utf8.decode(response.bodyBytes);
            final data = jsonDecode(responseString);
            if (data.containsKey('token')) {
              await prefs.setString('token', data['token']);
            }
            return {'success': true, 'data': data};
          } else {
            throw Exception(jsonDecode(response.body)['message'] ??
                "Verifikasi token gagal.");
          }
        } else {
          throw Exception("Gagal mendapatkan data pengguna.");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          throw Exception(
              "Akun ini sudah terdaftar dengan metode login lain. Silakan gunakan metode yang benar.");
        } else {
          throw Exception(e.message ?? "Login gagal.");
        }
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}
