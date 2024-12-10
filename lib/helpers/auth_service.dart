import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_plan/models/config.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      // Login dengan Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {"status": "error", "message": "Login dibatalkan oleh pengguna"};
      }

      // Ambil data profil Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Kirim token Google ke backend
      final response = await http.post(
        Uri.parse('$baseUrl/login-with-google'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "idToken": googleAuth.idToken,
          "email": googleUser.email,
          "name": googleUser.displayName,
          "picture": googleUser.photoUrl,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["status"] == "success") {
          // Simpan token JWT ke Shared Preferences
          await saveToken(responseData["token"]);

          return {
            "status": "success",
            "message": "Login berhasil",
            "user": responseData["user"],
          };
        } else {
          return {"status": "error", "message": responseData["message"]};
        }
      } else {
        return {"status": "error", "message": "Server error"};
      }
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
