import 'dart:convert';
import 'dart:io';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> uploadImage(File image) async {
  final url = Uri.parse('$baseUrl/predict'); // Correct URL definition
  
  try {
    var request = http.MultipartRequest('POST', url); // POST request to the correct URL
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var data = responseData.body;
      print(responseData.body);

      // Parsing data from the response and getting the prediction result
      var jsonResponse = jsonDecode(data); // Convert response to JSON
      String prediction = jsonResponse['prediction']; // Extract prediction

      return {'status': true, 'prediction': prediction}; // Return prediction
    } else {
      return {'status': false, 'message': 'Server error: ${response.statusCode}'};
    }
  } catch (e) {
    return {'status': false, 'message': 'Error: $e'};
  }
}
