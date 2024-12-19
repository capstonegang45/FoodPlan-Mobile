import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_plan/helpers/profile_helper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Profil'),
        backgroundColor: Colors.teal[900],
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          key: const Key('IconBack'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/beranda');
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan.'));
          }

          // Parsing data dari API
          final userData = snapshot.data!;
          Uint8List bytes =
              (userData['avatar'] != null && userData['avatar'].isNotEmpty)
                  ? base64Decode(userData['avatar'].split(',').last)
                  : Uint8List(0);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Background image with profile picture
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: CarouselSlider(
                        items: [
                          'assets/img/lean_clean.png',
                          'assets/img/nurture_nourish.png',
                          'assets/img/balanced_meal.png',
                        ].map((path) {
                          return Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      child: CircleAvatar(
                        key: const Key('AvatarProfile'),
                        radius: 55,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (bytes.isNotEmpty
                                ? MemoryImage(bytes)
                                : const AssetImage('assets/img/icons8.png')
                                    as ImageProvider),
                      ),
                    ),
                    Positioned(
                      bottom: -28,
                      right: MediaQuery.of(context).size.width / 2.5 - 9,
                      child: InkWell(
                        key: const Key('ShowImagePicker'),
                        onTap: showImagePicker,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white),
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              color: Colors.teal,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  userData['nama'] ?? 'Nama tidak ditemukan',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  userData['email'] ?? 'Email tidak ditemukan',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildInfoCard(
                          'Program Diet', userData['tipeDiet'] ?? 'Tidak ada'),
                      _buildInfoCard(
                          'Jenis Kelamin', userData['jKelamin'] ?? 'Tidak ada'),
                      _buildInfoCard('Password',
                          userData['password'] != null ? '*****' : 'Tidak ada'),
                      _buildInfoCard(
                          'Usia', userData['usia']?.toString() ?? '-'),
                      _buildInfoCard('Tinggi Badan',
                          userData['tBadan']?.toString() ?? '-'),
                      _buildInfoCard(
                          'Berat Badan', userData['bBadan']?.toString() ?? '-'),
                      _buildInfoCard('Riwayat Kesehatan',
                          userData['riwayat'] ?? 'Tidak ada'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    TextEditingController controller = TextEditingController(text: value);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            IconButton(
              key: const Key('Edit'),
              icon: const Icon(Icons.edit, color: Colors.teal),
              onPressed: () => _showEditDialog(title, controller),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String title, TextEditingController controller) {
    final Map<String, int> dietMap = {
      'Diet Normal': 1,
      'Diet Berat Badan': 2,
      'Diet Sport': 3,
      'Diet Khusus': 4,
      'Diet 2 Nyawa': 5,
    };

    List<String> options = [];
    if (title == "Jenis Kelamin") {
      options = ['Laki-Laki', 'Perempuan'];
    } else if (title == "Program Diet") {
      options = dietMap.keys.toList();
    }

    String? selectedValue = controller.text.isNotEmpty
        ? controller.text
        : (options.isNotEmpty ? options[0] : null);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: options.isNotEmpty
              ? DropdownButtonFormField<String>(
                  key: const Key('DropDownButton'),
                  value: selectedValue,
                  items: options
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: title,
                  ),
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: title,
                  ),
                ),
          actions: <Widget>[
            TextButton(
              key: const Key('Simpan'),
              onPressed: () {
                if (title == "Program Diet" &&
                    selectedValue != null &&
                    dietMap.containsKey(selectedValue)) {
                  int dietValue = dietMap[selectedValue!]!;
                  updateProfileField(title, dietValue.toString());
                } else if (options.isNotEmpty && selectedValue != null) {
                  updateProfileField(title, selectedValue!);
                } else {
                  updateProfileField(title, controller.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Gambar'),
              onTap: () async {
                Navigator.pop(context);
                await pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Pilih dari Galeri'),
              onTap: () async {
                Navigator.pop(context);
                await pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      uploadProfileImage(_profileImage!);
    }
  }
}
