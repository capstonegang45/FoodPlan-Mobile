// notifikasi_helper.dart
// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_plan/models/config.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:food_plan/models/notifikasi_model.dart';

Future<void> sendTimesToBackend(
  BuildContext context,
  String? token,
  TimeOfDay breakfastTime,
  TimeOfDay lunchTime,
  TimeOfDay dinnerTime,
) async {
  final url = Uri.parse('$baseUrl/schedule_notifications');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokens = prefs.getString('token');

  if (tokens == null || tokens.isEmpty) {
    throw Exception('Token tidak ditemukan');
  }
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $tokens'},
      body: json.encode({
        'token': token, // Send the token to the backend
        'breakfast_time':
            '${breakfastTime.hour.toString().padLeft(2, '0')}:${breakfastTime.minute.toString().padLeft(2, '0')}',
        'lunch_time':
            '${lunchTime.hour.toString().padLeft(2, '0')}:${lunchTime.minute.toString().padLeft(2, '0')}',
        'dinner_time':
            '${dinnerTime.hour.toString().padLeft(2, '0')}:${dinnerTime.minute.toString().padLeft(2, '0')}',
      }),
    );

    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      await showCustomToastNotification(
        context: context,
        title: 'Success!',
        message: responseData['message'],
        type: ToastificationType.success,
      );
    } else {
      await showCustomToastNotification(
        context: context,
        title: 'Error!',
        message: responseData['message'],
        type: ToastificationType.error,
      );
    }
  } catch (e) {
    await showCustomToastNotification(
      context: context,
      title: 'Error!',
      message: 'Error sending times: $e',
      type: ToastificationType.error,
    );
  }
}

Future<List<NotifikasiModel>> fetchNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokens = prefs.getString('token');

  if (tokens == null || tokens.isEmpty) {
    throw Exception('Token tidak ditemukan');
  }
  final response = await http.get(
    Uri.parse('$baseUrl/notifications'),
    headers: {
      'Authorization': 'Bearer $tokens',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body)['data'];
    return jsonData.map((data) => NotifikasiModel.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load notifications');
  }
}