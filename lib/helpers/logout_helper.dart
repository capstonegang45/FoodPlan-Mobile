import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutHelper {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found. Please login again.");
    }

    String apiUrl = "$baseUrl/logout-mobile"; // Ganti dengan URL API Anda
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Kirim token sebagai header Authorization
        },
      );

      if (response.statusCode == 200) {
        // Logout berhasil
        jsonDecode(response.body);

        // Hapus token setelah logout berhasil
        await prefs.remove('token');
      } else {
        // Jika gagal
        jsonDecode(response.body);
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }
}
