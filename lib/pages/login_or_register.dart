import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool _isHoveringMasuk = false;
  bool _isHoveringDaftar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustrasi Gambar
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/illustration.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Judul
            Text(
              'FOODPLAN',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            SizedBox(height: 10.0),

            // Deskripsi
            Text(
              'Temukan resep sehat, rencana diet, dan saran dari AI kami untuk mencapai tujuan dietmu. Mulai sekarang!',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            SizedBox(height: 10.0),

            // Placeholder teks tambahan
            // Text(
            //   'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when unknown printer took a galley',
            //   textAlign: TextAlign.justify,
            //   style: TextStyle(
            //     fontSize: 14.0,
            //     color: Colors.black,
            //   ),
            // ),
            SizedBox(height: 30.0),

            // Tombol Masuk dengan efek hover
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: MouseRegion(
                onHover: (event) => setState(() => _isHoveringMasuk = true),
                onExit: (event) => setState(() => _isHoveringMasuk = false),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isHoveringMasuk ? Colors.white : Color.fromARGB(255, 68, 91, 75),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.green[900]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'MASUK',
                      style: TextStyle(
                        color:
                            _isHoveringMasuk ? Color.fromARGB(255, 68, 91, 75) : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              // Tombol Daftar dengan efek hover
              child: MouseRegion(
                onHover: (event) => setState(() => _isHoveringDaftar = true),
                onExit: (event) => setState(() => _isHoveringDaftar = false),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isHoveringDaftar ? Color.fromARGB(255, 68, 91, 75) : Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color:
                          _isHoveringDaftar ? Colors.white : Color.fromARGB(255, 68, 91, 75),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'DAFTAR',
                      style: TextStyle(
                        color: _isHoveringDaftar
                            ? Colors.white
                            : Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
