import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future<void> showCustomToastNotification({
  required BuildContext context,
  required String title,
  required String message,
  required ToastificationType type,
}) async {
  // ignore: await_only_futures
  await Toastification().show(
    context: context,
    type: type, // Jenis notifikasi
    title: Text(title), // Judul notifikasi
    description: Text(message), // Deskripsi notifikasi
    alignment: Alignment.topCenter, // Posisi notifikasi
    autoCloseDuration: const Duration(seconds: 3), // Durasi otomatis menutup
    backgroundColor: Colors.white, // Warna latar belakang
    icon: Icon(
      type == ToastificationType.success
          ? Icons.check_circle
          : type == ToastificationType.error
              ? Icons.error
              : type == ToastificationType.info
                  ? Icons.info
                  : Icons.warning,
      color: type == ToastificationType.success
          ? Colors.green
          : type == ToastificationType.error
              ? Colors.red
              : type == ToastificationType.info
                  ? Colors.blue
                  : Colors.orange,
      size: 30,
    ), // Ikon berdasarkan jenis notifikasi
  );
}
