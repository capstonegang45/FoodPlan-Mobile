import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> sendMessageAndGetResponse(String message) async {
  final url = Uri.parse('$baseUrl/chat_response');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null || token.isEmpty) {
    throw Exception('Token tidak ditemukan');
  }

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({'message': message}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body); // Respons berupa Map
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}