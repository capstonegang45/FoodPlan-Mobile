import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_plan/models/config.dart';


Future<Map<String, dynamic>> login(String email, String password) async {

  final url = Uri.parse("$baseUrl/login");

  final loginData = {
    'email': email,
    'password': password,
  };

  try {
    // Mengatur headers untuk Content-Type 'application/json'
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      String body = response.body.trim();
      if (body.contains('{')) {
        body = body.substring(body.indexOf('{'));
      }

      final data = json.decode(body);
      return data;
    } else {
      return {
        'status': 'error',
        'message': 'Failed to login: ${response.statusCode} - ${response.reasonPhrase}'
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'An error occurred while trying to login: $e'
    };
  }
}
