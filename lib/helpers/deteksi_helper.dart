// deteksi_helper.dart
import 'dart:convert';
import 'dart:io';
import 'package:food_plan/models/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeteksiHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<Map<String, dynamic>> uploadAndDetect(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found. Please login again.");
    }

    final uri = Uri.parse("$baseUrl/predict");
    final request = http.MultipartRequest("POST", uri);

    request.headers["Authorization"] = "Bearer $token";
    request.headers["Content-Type"] = "application/json";
    request.headers["Accept"] = "application/json";

    request.files.add(
      await http.MultipartFile.fromPath("file", image.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = json.decode(responseBody);

      // Parse detections and products from the response
      final detections = (responseJson['data']['detections'] as List<dynamic>?)
              ?.map((detection) => detection['class_name'].toString())
              .toList() ??
          [];
      final products = responseJson['data']['products'];

      return {
        'detections': detections,
        'products': products,
      };
    } else {
      final errorBody = await response.stream.bytesToString();
      throw Exception("Error: ${response.statusCode}, $errorBody");
    }
  }
}
