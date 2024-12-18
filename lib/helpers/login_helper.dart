import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_plan/models/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse("$baseUrl/login");

  final loginData = {
    'email': email,
    'password': password,
  };

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Simpan token ke SharedPreferences
      if (data.containsKey('token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
      }

      return data;
    } else {
      return {
        'status': 'error',
        'message':
            'Failed to login: ${response.statusCode} - ${response.reasonPhrase}'
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'An error occurred while trying to login: $e'
    };
  }
}

Future<Map<String, dynamic>> logout() async {
  final url = Uri.parse("$baseUrl/logout");

  try {
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'status': 'success',
        'message': data['message'] ?? 'Logout successful',
      };
    } else {
      return {
        'status': 'error',
        'message':
            'Failed to logout: ${response.statusCode} - ${response.reasonPhrase}'
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'An error occurred while trying to logout: $e'
    };
  }
}

Future<Map<String, dynamic>> fetchUserProfile() async {
  final url = Uri.parse("$baseUrl/profile");

  try {
    final headers = await getHeaders();
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'status': 'success',
        'data': data,
      };
    } else {
      return {
        'status': 'error',
        'message':
            'Failed to fetch profile: ${response.statusCode} - ${response.reasonPhrase}'
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'An error occurred while trying to fetch profile: $e'
    };
  }
}

Future<Map<String, String>> getHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  return {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}
