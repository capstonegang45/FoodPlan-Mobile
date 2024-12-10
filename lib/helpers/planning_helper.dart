import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlanningHelper {
  Future<List<dynamic>> fetchPlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    final uri = Uri.parse('$baseUrl/planning-page');
    print('Request URL: $uri');

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Error parsing JSON: $e');
        throw Exception('Failed to parse response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Token invalid atau expired');
    } else {
      throw Exception('Failed to load plans: ${response.reasonPhrase}');
    }
  }
}

