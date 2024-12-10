import 'dart:convert';
import 'dart:io';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> uploadImages(List<File> images) async {
  final url = Uri.parse('$baseUrl/predict'); // Base URL dari API

  try {
    var request = http.MultipartRequest('POST', url);

    // Tambahkan semua file ke dalam request
    for (var image in images) {
      request.files.add(await http.MultipartFile.fromPath('files', image.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(responseData.body);

      if (jsonResponse.containsKey('results')) {
        return {
          'status': true,
          'results': jsonResponse['results'], // Hasil prediksi untuk setiap gambar
        };
      } else {
        return {
          'status': false,
          'message': 'Response tidak valid dari server.',
        };
      }
    } else {
      return {
        'status': false,
        'message': 'Server error: ${response.statusCode}',
      };
    }
  } on SocketException catch (_) {
    return {
      'status': false,
      'message': 'Tidak dapat terhubung ke server. Periksa koneksi Anda.',
    };
  } catch (e) {
    return {
      'status': false,
      'message': 'Error tidak terduga: $e',
    };
  }
}

