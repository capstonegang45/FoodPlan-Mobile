import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
        // Ensure scrolling capability
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align items at the start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered logo
            Center(
              child: Image.asset('assets/img/logolagi.png', height: 130),
            ),
            SizedBox(height: 10),

            Text(
              'Masuk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            SizedBox(height: 5),

            // Left-aligned subtitle
            Text(
              'Masuk untuk melanjutkan menggunakan aplikasi',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(height: 15),

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
              ),
            ),
            SizedBox(height: 10),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Lupa Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Login button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/validasi');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 68, 91, 75),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'MASUK',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Google login option
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Atau Gunakan'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/img/google.png',
                  height: 50,
                ),
              ),
            ),

            // Register option
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 68, 91, 75),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
