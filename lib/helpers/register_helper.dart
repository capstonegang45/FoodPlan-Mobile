import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_plan/models/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> register(
    String nama, String username, String email, String password) async {
  final url = Uri.parse("$baseUrl/register");

  final registerData = {
    'nama': nama,
    'username': username,
    'email': email,
    'password': password,
  };

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(registerData),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final token = data['token'];
      if (token == null) {
        return {
          'status': 'error',
          'message': 'Token tidak ditemukan di respons.',
        };
      }
      await saveToken(token); // Ambil token dari respons

      return {
        'status': 'success',
        'message': data['message'],
        'token': token, // Kirimkan token bersama data lain
        'user': {
          'id': data['user']['id'],
          'nama': data['user']['nama'],
          'email': data['user']['email'],
          'role_id': data['user']['role_id'],
        },
      };
    } else {
      return {
        'status': 'error',
        'message': json.decode(response.body)['message'] ??
            'Failed to register: ${response.statusCode} - ${response.reasonPhrase}',
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'An error occurred while trying to register: $e',
    };
  }
}

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token); // Simpan token dengan kunci 'token'
}
