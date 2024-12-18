import 'package:flutter/material.dart';
import 'package:food_plan/helpers/register_helper.dart';
import 'package:food_plan/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final nama = _namaController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validasi input
    if (nama.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Semua field harus diisi.';
      });
      return;
    }
    if (password != confirmPassword) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password dan konfirmasi password tidak sama.';
      });
      return;
    }

    // Panggil fungsi register
    final response = await register(nama, username, email, password);

    setState(() {
      _isLoading = false;
    });

    if (response['status'] == 'success') {
      // Menyimpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);

      // Navigasi ke halaman validasi
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/validasi');
    } else {
      // Tampilkan pesan error
      setState(() {
        _errorMessage = response['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/img/logolagi.png', height: 130),
            ),
            const SizedBox(height: 10),

            const Text(
              'Daftar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            const SizedBox(height: 5),

            const Text(
              'Daftar terlebih dahulu untuk melanjutkan',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            // Nama
            _buildTextField('Nama Pengguna', _namaController),
            const SizedBox(height: 10),

            // Username
            _buildTextField('Username', _usernameController),
            const SizedBox(height: 10),

            // Email
            _buildTextField('Email', _emailController),
            const SizedBox(height: 10),

            customTextField(
              key: Key('sandi'),
              controller: _passwordController,
              labelText: 'Kata sandi',
              hintText: 'Masukkan kata sandi Anda',
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 68, 91, 75),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            customTextField(
              key: Key('cusrsandi'),
              controller: _confirmPasswordController,
              labelText: 'Konfirmasi Kata sandi',
              hintText: 'Masukkan ulang kata sandi Anda',
              obscureText: !_isConfirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color.fromARGB(255, 68, 91, 75),
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Tampilkan pesan error jika ada
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),

            // Tombol Register
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Daftar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for text fields
  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: const Color.fromARGB(255, 68, 91, 75),
      style: const TextStyle(color: Color.fromARGB(255, 68, 91, 75)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
        hintText: 'Masukkan $label',
        hintStyle: const TextStyle(
            color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
