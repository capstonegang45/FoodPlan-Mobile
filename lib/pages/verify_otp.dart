import 'dart:convert';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:food_plan/pages/reset_password.dart';

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

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    // Gabungkan input OTP dari semua kotak
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.isEmpty || otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('OTP tidak boleh kosong atau kurang dari 6 digit!'),
      ));
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
        // Berhasil verifikasi OTP
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData['message']),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResetPasswordPage(email: widget.email, otp: otp),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData['message']),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Terjadi kesalahan!'),
      ));
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
        title: const Text(
          'Verifikasi OTP',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.teal[900],
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
                'assets/img/logolagi.png', // Ganti dengan path logo Anda
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
                        backgroundColor: const Color(0xFF2E7D32),
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
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Fitur kirim ulang OTP belum tersedia'),
                  ));
                },
                child: const Text(
                  "Kirim ulang OTP?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
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
