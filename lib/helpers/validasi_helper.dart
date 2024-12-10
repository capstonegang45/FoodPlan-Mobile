import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ValidasiHelper {
  final String apiUrl = "$baseUrl/validate"; // Ganti dengan URL backend Anda

  // Fungsi untuk mengirimkan data validasi
  Future<Map<String, dynamic>> submitValidationData({
    required int usia,
    required String jenisKelamin,
    required int tinggiBadan,
    required int beratBadan,
    required String riwayat,
    required int categoryId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan atau kosong');
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Pastikan token dikirim dengan benar
      },
      body: json.encode({
        'usia': usia,
        'jenis_kelamin': jenisKelamin,
        'tinggi_badan': tinggiBadan,
        'berat_badan': beratBadan,
        'riwayat': riwayat,
        'category_id': categoryId,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Mengembalikan response jika berhasil
    } else {
      throw Exception('Gagal mengirim data');
    }
  }
}
