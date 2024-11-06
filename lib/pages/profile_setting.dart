import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Profil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Background image with profile picture
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip
                  .none, // Memungkinkan posisi elemen berada di luar container
              children: [
                // Background gambar
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/lean_clean.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Foto profil
                Positioned(
                  bottom:
                      -30, 
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/img/icons8.png'),
                  ),
                ),

                // edit profil
                Positioned(
                  bottom:
                      -28, // Mengatur posisi agar ikon berada di pojok bawah CircleAvatar
                  right: MediaQuery.of(context).size.width / 2.5 -
                      9, // Sesuaikan agar ikon di pojok kanan bawah
                  child: CircleAvatar(
                    radius: 15, // Ukuran ikon lebih kecil
                    backgroundColor: Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.edit, color: Colors.white, size: 15),
                      onPressed: () {
                        // Implementasi fungsi edit profil
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40), // Space for the profile picture

            // Profile details
            Text(
              'Ilham Hatta Manggala',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('admin123@gmail.com', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),

            // Information fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ProfileInfoRow(
                      label: 'Program Diet', value: 'Diet Berat Badan'),
                  ProfileInfoRow(label: 'Usia', value: '22'),
                  ProfileInfoRow(label: 'Tinggi Badan', value: '159'),
                  ProfileInfoRow(label: 'Berat Badan', value: '50'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
