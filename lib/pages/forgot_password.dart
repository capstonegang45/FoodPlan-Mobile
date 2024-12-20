// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_plan/models/config.dart';
import 'package:food_plan/pages/verify_otp.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toastification/toastification.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    if (email.isEmpty) {
      await showCustomToastNotification(
        context: context,
        title: 'Error',
        message: 'Email tidak boleh kosong!',
        type: ToastificationType.error // Warna merah untuk kesalahan
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('$baseUrl/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email}),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        await showCustomToastNotification(
          context: context, 
          title: 'Success', 
          message: responseData['message'], 
          type: ToastificationType.success
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtpPage(email: email),
          ),
        );
      } else {
        await showCustomToastNotification(
          context: context,
          title: 'Error',
          message: responseData['message'],
          type: ToastificationType.error // Warna merah untuk kesalahan
        );
      }
    } catch (error) {
      await showCustomToastNotification(
        context: context,
        title: 'Error',
        message: 'Terjadi kesalahan!',
        type: ToastificationType.error// Warna merah untuk kesalahan
      );
    } finally {
      setState(() {
        _isLoading = false;
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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lupa Kata Sandi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Masukkan email Anda untuk mendapatkan kode OTP guna mereset kata sandi.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.teal[900]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal[900]!),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.teal[900]),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _isLoading ? null : _sendOTP,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Kirim OTP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
