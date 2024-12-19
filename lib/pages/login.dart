// import 'dart:convert';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_plan/widgets/customBtnBorder.dart';
// import 'package:food_plan/models/config.dart';
// import 'package:http/http.dart' as http;
import '../helpers/login_helper.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  final bool _isLoading = false;
  String _message = '';
  bool _isPasswordVisible = false;

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validate input
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Both fields are required.';
      });
      _showErrorDialog(_message);
      return;
    }

    // Call the login helper function
    final response = await login(email, password);
    setState(() {
      _message = response['message'];
    });

    if (response.containsKey('user')) {
      // If 'user' is present in the response, login is successful
      _showSuccessDialog(_message);
    } else {
      // If no 'user' key, it's an error response
      _showErrorDialog(_message);
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Successful'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/validasi');
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset('assets/img/logolagi.png', height: 130),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 68, 91, 75),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Masuk untuk melanjutkan menggunakan aplikasi',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),

                  // Email input
                  customTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Masukkan email Anda',
                  ),
                  const SizedBox(height: 10),

                  // Password input
                  customTextField(
                    controller: _passwordController,
                    labelText: 'Kata sandi',
                    hintText: 'Masukkan kata sandi Anda',
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/lupapassword');
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    key: const Key('loginButton'),
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'MASUK',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Atau Gunakan'),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: CustomButtonBorder(
                      height: 45,
                      icon: FontAwesomeIcons.github,
                      label: "Masuk dengan akun Github",
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: CustomButtonBorder(
                      height: 45,
                      icon: FontAwesomeIcons.google,
                      label: "Masuk dengan akun Google",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bagian "Belum punya akun?" di bawah, tidak akan scroll
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 68, 91, 75),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
