// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_plan/helpers/notifikasi_heper.dart';
import 'package:food_plan/models/notifikasi_model.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:toastification/toastification.dart';

class TimeSettingsPage extends StatefulWidget {
  const TimeSettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeSettingsPageState createState() => _TimeSettingsPageState();
}

class _TimeSettingsPageState extends State<TimeSettingsPage> {
  TimeOfDay breakfastTime = const TimeOfDay(hour: 7, minute: 30);
  TimeOfDay lunchTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay dinnerTime = const TimeOfDay(hour: 20, minute: 0);
  String? token;
  bool isLoading = true;
  List<NotifikasiModel> notifications = [];
  bool isFetchingNotifications = true;

  @override
  void initState() {
    super.initState();
    getToken();
    fetchAndSetNotifications();
  }

  Future<void> fetchAndSetNotifications() async {
    try {
      notifications = await fetchNotifications();
      if (notifications.isNotEmpty) {
        setState(() {
          // Gunakan waktu default jika nilai dari API null
          breakfastTime = _parseTime(
              notifications[0].pagi, const TimeOfDay(hour: 7, minute: 30));
          lunchTime = _parseTime(
              notifications[0].siang, const TimeOfDay(hour: 12, minute: 0));
          dinnerTime = _parseTime(
              notifications[0].malem, const TimeOfDay(hour: 20, minute: 0));
        });
      }
    } catch (e) {
      showCustomToastNotification(
        context: context,
        title: 'Error!',
        message: 'Failed to fetch notifications: $e',
        type: ToastificationType.error,
      );
    } finally {
      setState(() {
        isFetchingNotifications = false;
      });
    }
  }

  TimeOfDay _parseTime(String? time, TimeOfDay defaultTime) {
    if (time == null || time.isEmpty) {
      return defaultTime; // Jika data null, gunakan waktu default
    }
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  Future<void> getToken() async {
    try {
      token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        showCustomToastNotification(
          context: context,
          title: 'Error!',
          message: 'Failed to get Firebase token',
          type: ToastificationType.error,
        );
      }
    } catch (e) {
      showCustomToastNotification(
        context: context,
        title: 'Error!',
        message: 'Error fetching token: $e',
        type: ToastificationType.error,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String mealType) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: mealType == 'breakfast'
          ? breakfastTime
          : mealType == 'lunch'
              ? lunchTime
              : dinnerTime,
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        if (mealType == 'breakfast') {
          breakfastTime = picked;
        } else if (mealType == 'lunch') {
          lunchTime = picked;
        } else {
          dinnerTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
          'FOODPLAN APP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/beranda');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isFetchingNotifications
            ? Center(child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading...',
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900]),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                pause: const Duration(
                    milliseconds: 300), // Pause between repetitions
              ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTimeCard('Sarapan Pagi', breakfastTime.format(context),
                      'breakfast'),
                  const SizedBox(height: 10),
                  _buildTimeCard(
                      'Makan Siang', lunchTime.format(context), 'lunch'),
                  const SizedBox(height: 10),
                  _buildTimeCard(
                      'Makan Malem', dinnerTime.format(context), 'dinner'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/beranda');
                            showCustomToastNotification(
                              context: context,
                              title: 'Tidak Jadi!',
                              message: 'Tidak ada perubahan!',
                              type: ToastificationType.info,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text("Kembali",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: token == null || isLoading
                              ? null
                              : () async {
                                  await sendTimesToBackend(
                                    context,
                                    token!,
                                    breakfastTime,
                                    lunchTime,
                                    dinnerTime,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.teal[900],
                          ),
                          child: const Text("Simpan",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTimeCard(String title, String time, String mealType) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(time,
            style: const TextStyle(fontSize: 14, color: Colors.grey)),
        trailing: const Icon(Icons.access_time),
        onTap: () => _selectTime(context, mealType),
      ),
    );
  }
}
