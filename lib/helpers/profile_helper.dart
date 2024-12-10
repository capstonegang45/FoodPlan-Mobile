import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:food_plan/models/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> userProfile() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user-profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Parsing JSON response
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> uploadProfileImage(File image) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }
    // Baca file gambar menjadi byte array
    final bytes = await image.readAsBytes();
    // Konversi gambar menjadi string base64
    String base64Image = base64Encode(bytes);

    print(base64Image);

    // Kirim permintaan POST ke backend Flask
    var response = await http.post(
      Uri.parse('$baseUrl/upload-profile-image'),  // Ganti dengan URL Flask
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'avatar': base64Image,  // Kirim gambar sebagai base64
      }),
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Failed to upload image.');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

Future<void> updateProfileField(String field, dynamic value) async {
  final url = Uri.parse('$baseUrl/update-profile');

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'field': field,
        'value': value,
      }),
    );

    if (response.statusCode == 200) {
      print('Data berhasil diperbarui: ${response.body}');
    } else {
      print('Gagal memperbarui data: ${response.body}');
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error saat mengupdate data: $e');
  }
}
