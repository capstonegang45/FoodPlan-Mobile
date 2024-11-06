import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        // Allows for scrolling on smaller screens
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/img/logolagi.png', height: 130),
            ),
            SizedBox(height: 10),

            Text(
              'Daftar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            SizedBox(height: 5),

            // Left-aligned subtitle
            Text(
              'Daftar terlebih dahulu untuk melanjutkan',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(height: 15),

            // Name field
            TextField(
              cursorColor: Color.fromARGB(255, 68, 91, 75),
              style: TextStyle(color: Color.fromARGB(255, 68, 91, 75)),
              decoration: InputDecoration(
                labelText: 'Nama Pengguna',
                labelStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                hintText: 'Masukkan nama Anda',
                hintStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Email field
            TextField(
              cursorColor: Color.fromARGB(255, 68, 91, 75),
              style: TextStyle(color: Color.fromARGB(255, 68, 91, 75)),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                hintText: 'Masukkan email Anda',
                hintStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Password field
            TextField(
              obscureText: true,
              cursorColor: Color.fromARGB(255, 68, 91, 75),
              style: TextStyle(color: Color.fromARGB(255, 68, 91, 75)),
              decoration: InputDecoration(
                labelText: 'Kata sandi',
                labelStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                hintText: 'Masukkan kata sandi Anda',
                hintStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon:
                    Icon(Icons.visibility_off, color: Color.fromARGB(255, 68, 91, 75)),
              ),
            ),
            SizedBox(height: 10),

            // Confirm Password field
            TextField(
              obscureText: true,
              cursorColor: Color.fromARGB(255, 68, 91, 75),
              style: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
              decoration: InputDecoration(
                labelText: 'Konfirmasi kata sandi',
                labelStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                hintText: 'Masukkan kata sandi Anda lagi',
                hintStyle: TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon:
                    Icon(Icons.visibility_off, color: Color.fromARGB(255, 68, 91, 75)),
              ),
            ),
            SizedBox(height: 30),

            // Register button

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/validasi');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 68, 91, 75),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Daftar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
