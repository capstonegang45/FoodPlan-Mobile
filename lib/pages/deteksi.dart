import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_bottom_nav.dart';

class DeteksiPage extends StatefulWidget {
  const DeteksiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeteksiPageState createState() => _DeteksiPageState();
}

class _DeteksiPageState extends State<DeteksiPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  int _selectedIndex = 1;
  bool _isDetected = false; // Status deteksi
  String _detectionResult = ""; // Hasil deteksi

  // Function to open the camera and select an image
  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _isDetected = false; // Reset status deteksi saat gambar baru dipilih
      });
    }
  }

  // Function to open the gallery and select an image
  Future<void> _openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _isDetected = false; // Reset status deteksi saat gambar baru dipilih
      });
    }
  }

  // Function to handle detection
  void _detectImage() {
    
    setState(() {
      _detectionResult = "Ayam"; // Hasil deteksi (misalnya ayam)
      _isDetected = true; // Update status deteksi
    });
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/beranda');
          break;
        case 1:
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/rencana');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 91, 75),
        title: const Text(
          'FOODPLAN APP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display selected image only if it's not null
                if (_selectedImage != null)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(width: 16),
                // Camera and Gallery buttons
                GestureDetector(
                  onTap: _openCamera,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(Icons.camera_alt,
                        size: 40, color: Color.fromARGB(255, 68, 91, 75)),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _openGallery,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(Icons.photo,
                        size: 40, color: Color.fromARGB(255, 68, 91, 75)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _selectedImage != null ? _detectImage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 68, 91, 75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                ),
                child: const Text(
                  'Deteksi',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 68, 91, 75)),
                ),
              ),
            ),
            if (_isDetected) ...[
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Deteksi Berhasil!",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hasil Deteksi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("1. $_detectionResult"),
              const SizedBox(height: 20),
              const Text(
                "Rekomendasi Makanan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Misalnya menampilkan 5 rekomendasi
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.asset('assets/img/makan.png',
                            width: 50), 
                        title: const Text("Capcay Brokoli"),
                        subtitle: const Text(
                            "Sajian capcay yang biasanya hadir dengan beragam jenis sayuran juga bisa dibuat dengan satu macam..."),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
