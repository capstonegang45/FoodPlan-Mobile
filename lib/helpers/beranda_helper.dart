import 'dart:convert';
import 'package:food_plan/models/produk.dart';
import 'package:http/http.dart' as http;
import 'package:food_plan/models/config.dart';

Future<List<Product>> fetchProducts() async {
  final response = await http.get(
    Uri.parse('$baseUrl/produk-page'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    // print(response.body);
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Gagal mengambil produk');
  }
}
