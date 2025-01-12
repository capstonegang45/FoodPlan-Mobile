import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FacebookSignInHelper {
  static Future<Map<String, dynamic>> signInWithFacebook(
      String backendUrl) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final String? accessToken = loginResult.accessToken?.tokenString;

        if (accessToken == null) {
          throw Exception("Access token is null.");
        }

        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(accessToken);

        try {
          final UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);

          final String? idToken = await userCredential.user?.getIdToken();
          if (idToken == null) {
            throw Exception("Failed to get Firebase ID token.");
          }

          final response = await http.post(
            Uri.parse('$backendUrl/verify-facebook-token'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'accessToken': idToken}),
          );

          if (response.statusCode == 200) {
            final responseBody = jsonDecode(response.body);

            if (responseBody.containsKey('token')) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', responseBody['token']);
            }

            return {'success': true, 'data': responseBody};
          } else {
            throw Exception(
                jsonDecode(response.body)['message'] ?? "Failed to verify token.");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            throw Exception(
                "Akun ini sudah terdaftar dengan metode login lain. Silakan gunakan metode yang benar.");
          } else {
            throw Exception(e.message ?? "Login gagal.");
          }
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        throw Exception("Facebook login was cancelled.");
      } else {
        throw Exception("Facebook login failed: ${loginResult.message}");
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<void> signOut() async {
    await FacebookAuth.instance.logOut();// Logs out from Firebase
  }
}
