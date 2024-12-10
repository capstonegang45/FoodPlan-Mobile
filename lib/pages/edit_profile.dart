import 'package:flutter/material.dart';
import 'package:food_plan/widgets/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usiaController = TextEditingController();
  final TextEditingController _tipeController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _riwayatController = TextEditingController();
  
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama
              customTextField(
                controller: _namaController, 
                labelText: 'Nama Lengkap', 
                hintText: 'Masukkan Nama Lengkap'
              ),
              const SizedBox(height: 15),

              // Username
              customTextField(
                controller: _usernameController, 
                labelText: 'Username', 
                hintText: 'Masukkan Username'
              ),
              const SizedBox(height: 15),

              // Email
              customTextField(
                controller: _emailController, 
                labelText: 'Email', 
                hintText: 'Masukkan Email'
              ),
              const SizedBox(height: 15),

              // Password
              customTextField(
                controller: _passwordController, 
                labelText: 'Password', 
                hintText: 'Masukkan Password', 
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Usia
              customTextField(
                controller: _usiaController, 
                labelText: 'Usia', 
                hintText: 'Masukkan Usia',
                keyboardType: TextInputType.number
              ),
              const SizedBox(height: 15),

              // Tinggi Badan
              customTextField(
                controller: _tinggiController, 
                labelText: 'Tinggi Badan', 
                hintText: 'Masukkan Tinggi Badan',
                keyboardType: TextInputType.number
              ),
              const SizedBox(height: 15),

              // Berat Badan
              customTextField(
                controller: _beratController, 
                labelText: 'Berat Badan', 
                hintText: 'Masukkan Berat Badan',
                keyboardType: TextInputType.number
              ),
              const SizedBox(height: 15),

              // Tipe Diet
              customTextField(
                controller: _tipeController, 
                labelText: 'Tipe Diet', 
                hintText: 'Masukkan Tipe Diet'
              ),
              const SizedBox(height: 15),

              customTextField(
                controller: _riwayatController, 
                labelText: 'Riwayat', 
                hintText: 'Masukkan Riwayat Penyakit'
              ),
              const SizedBox(height: 20),

              // Simpan Button
              ElevatedButton(
                onPressed: () {
                  // Logika untuk menyimpan data
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Profil berhasil disimpan!'),
                  ));
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
