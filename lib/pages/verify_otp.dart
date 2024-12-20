// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:food_plan/pages/reset_password.dart';
import 'package:toastification/toastification.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;
  const VerifyOtpPage({super.key, required this.email});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  bool _isLoading = false;
  bool _isResendEnabled = false;
  bool _isResendInProgress = false; // New flag to avoid sending OTP repeatedly
  int _remainingTime = 300; // Timer countdown dalam detik (5 menit)
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = 300;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer?.cancel();
      }
    });
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    // Gabungkan input OTP dari semua kotak
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.isEmpty || otp.length < 6) {
      await showCustomToastNotification(
        context: context,
        title: "Error",
        message: 'OTP tidak boleh kosong atau kurang dari 6 digit!',
        type: ToastificationType.error, // Tipe dialog error
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('$baseUrl/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': widget.email,
          'otp': otp,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        await showCustomToastNotification(
          context: context,
          title: "Success",
          message: responseData['message'],
          type: ToastificationType.success, // Tipe dialog sukses
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResetPasswordPage(email: widget.email, otp: otp),
          ),
        );
      } else {
        await showCustomToastNotification(
          context: context,
          title: "Error",
          message: responseData['message'],
          type: ToastificationType.error, // Tipe dialog sukses
        );
      }
    } catch (e) {
      showCustomToastNotification(
        context: context,
        title: "Error",
        message: 'Error, Gagal melakukan verifikasi OTP. Coba lagi.',
        type: ToastificationType.success, // Tipe dialog sukses
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendOtp() async {
    if (_isResendInProgress) return; // Prevent multiple resend requests
    setState(() {
      _isResendInProgress = true;
    });

    final url = Uri.parse('$baseUrl/resend-otp');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': widget.email}),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        await showCustomToastNotification(
          context: context,
          title: "Success",
          message: responseData['message'],
          type: ToastificationType.success, // Tipe dialog sukses
        );

        _startResendCountdown(); // Start countdown timer after resend
      } else {
        await showCustomToastNotification(
          context: context,
          title: 'Error',
          message: responseData['message'],
          type: ToastificationType.error // Warna merah untuk kesalahan
        );
      }
    } catch (e) {
      await showCustomToastNotification(
        context: context,
        title: 'Error',
        message: 'Error, Gagal mengirim ulang OTP. Coba lagi.',
        type: ToastificationType.error// Warna merah untuk kesalahan
      );
    } finally {
      setState(() {
        _isResendInProgress = false;
      });
    }
  }

  void _startResendCountdown() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = 300; // Reset the timer
    });

    _timer?.cancel();
    _startTimer(); // Start the timer to count down again
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logolagi.png',
                height: 100,
              ),
              const SizedBox(height: 24),
              const Text(
                "MASUKKAN KODE OTP",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Kami telah mengirimkan kode OTP ke email Anda. Masukkan kode tersebut di bawah ini.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 16),
                      ),
                      child: const Text(
                        "Verifikasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              Text(
                "Kirim ulang OTP dalam: ${_formatTime(_remainingTime)}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              GestureDetector(
                onTap: _isResendEnabled
                    ? () {
                        _resendOtp();
                      }
                    : null,
                child: Text(
                  "Kirim ulang OTP?",
                  style: TextStyle(
                    fontSize: 16,
                    color: _isResendEnabled ? Colors.teal[900] : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
