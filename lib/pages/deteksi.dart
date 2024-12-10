import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_bottom_nav.dart';
import '../helpers/deteksi_helper.dart';

class DeteksiPage extends StatefulWidget {
  const DeteksiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeteksiPageState createState() => _DeteksiPageState();
}

class _DeteksiPageState extends State<DeteksiPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  int _selectedIndex = 1;
  bool _isDetected = false;
  List<dynamic> _detectionResults = []; // Menyimpan hasil deteksi untuk semua gambar

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImages = [File(image.path)];
        _isDetected = false;
      });
    }
  }

  Future<void> _openGallery() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? images = await _picker.pickMultiImage(); // Pilih beberapa gambar
    if (images != null) {
      setState(() {
        _selectedImages = images.map((image) => File(image.path)).toList();
        _isDetected = false;
      });
    }
  }

  Future<void> _detectImages() async {
    if (_selectedImages.isEmpty) return;

    final result = await uploadImages(_selectedImages); // Panggil fungsi uploadImages
    if (result['status']) {
      setState(() {
        _detectionResults = result['results']; // Hasil prediksi untuk semua gambar
        _isDetected = true;
      });
    } else {
      _showErrorDialog(result['message']);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedImages.isNotEmpty)
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _selectedImages.map((image) {
                          return Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
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
            ElevatedButton(
              onPressed: _selectedImages.isNotEmpty ? _detectImages : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 34, 70, 34)), // Warna hijau tua
                foregroundColor:
                    WidgetStateProperty.all(Colors.white), // Warna teks putih
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Radius sudut tombol
                  ),
                ),
                minimumSize: WidgetStateProperty.all(const Size(
                    double.infinity, 50)), // Lebar penuh dan tinggi 50
              ),
              child: const Text('Deteksi',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            if (_isDetected) ...[
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _detectionResults.length,
                  itemBuilder: (context, index) {
                    final result = _detectionResults[index];
                    String filename = result['filename'] ?? 'Unknown';
                    String prediction =
                        result['prediction'] ?? 'Prediction failed';
                    String error = result['error'] ?? '';

                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: Text(
                          filename,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: error.isNotEmpty
                            ? Text(
                                "Error: $error",
                                style: const TextStyle(color: Colors.red),
                              )
                            : Text("Prediction: $prediction"),
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
