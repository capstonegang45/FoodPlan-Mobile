// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import '../widgets/custom_bottom_nav.dart';
import '../helpers/deteksi_helper.dart';
import '../widgets/diet_card_small.dart'; // Import DietCardSmall

class DeteksiPage extends StatefulWidget {
  const DeteksiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeteksiPageState createState() => _DeteksiPageState();
}

class _DeteksiPageState extends State<DeteksiPage> {
  int _selectedIndex = 1;
  File? _image;
  bool _isLoading = false;
  List<String> _result = [];
  List<dynamic> _matchingProducts = [];
  final DeteksiHelper _helper = DeteksiHelper();

  // Fungsi untuk memilih gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    final image = await _helper.pickImageFromCamera();
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  // Fungsi untuk mengupload gambar dan mendeteksi isinya
  Future<void> _uploadAndDetect() async {
    if (_image == null) {
      await showCustomToastNotification(
          context: context,
          title: 'Error',
          message: "Silakan pilih gambar terlebih dahulu",
          type: ToastificationType.error);
      return;
    }

    setState(() {
      _isLoading = true;
      _result.clear();
      _matchingProducts.clear();
    });

    try {
      final result = await _helper.uploadAndDetect(_image!);

      if (result['detections'] == null || result['products'] == null) {
        throw Exception("Hasil deteksi tidak valid.");
      }

      setState(() {
        _result = (result['detections'] as List<String>).toSet().toList();
        if (_result.contains("Bukan bahan makanan")) {
          showCustomToastNotification(
            context: context,
            title: 'Peringatan',
            message: "Gambar yang dipilih bukan bahan makanan!",
            type: ToastificationType.warning,
          );
          return;
        }
        _matchingProducts = result['products'];
      });
    } catch (e) {
      await showCustomToastNotification(
          context: context,
          title: 'Error',
          message: "Terjadi kesalahan saat mendapatkan hasil deteksi",
          type: ToastificationType.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Menampilkan modal untuk memilih gambar atau menampilkan gambar yang ada
  // ignore: unused_element
  Future<void> _showImagePickerModal() async {
    // Ambil direktori tempat gambar disimpan
    final directory = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory('${directory.path}/images');

    // Jika folder belum ada, buat folder baru
    if (!await imagesDirectory.exists()) {
      await imagesDirectory.create(recursive: true);
    }

    // Ambil semua file gambar yang ada di folder
    final imageFiles = imagesDirectory
        .listSync()
        .where((item) =>
            item is File &&
            (item.path.endsWith('.jpg') ||
                item.path.endsWith('.png') ||
                item.path.endsWith('.jpeg')))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          key: const Key('bottomSheetImage'),
          height: MediaQuery.of(context).size.height * 0.5, // 60% dari layar
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[900],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      key: const Key('ButtonImages'),
                      leading: const Icon(Icons.photo_library, color: Colors.white,),
                      title: const Text('Pilih gambar dari galeri', style: TextStyle(color: Colors.white),),
                      onTap: () async {
                        final image = await _helper.pickImageFromGallery();
                        if (image != null) {
                          final timestamp =
                              DateTime.now().millisecondsSinceEpoch;
                          final newFilePath =
                              '${imagesDirectory.path}/image_$timestamp.jpg';

                          await image.copy(newFilePath);

                          showCustomToastNotification(
                            context: context,
                            title: 'Berhasil',
                            message:
                                'Gambar berhasil disimpan di local storage',
                            type: ToastificationType.success,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (imageFiles.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: imageFiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        final file = imageFiles[index] as File;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = File(file.path);
                            });
                            Navigator.pop(context);
                          },
                          child: Image.file(
                            file,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menangani navigasi ketika item bottom nav dipilih
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
          Navigator.pushReplacementNamed(context, '/chatbot');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/rencana');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
          'FOODPLAN APP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _image != null
                        ? Image.file(
                            key: const Key('Image'),
                            _image!,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text("Gambar belum dipilih"),
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      GestureDetector(
                        key: const Key('GestureDetectorCamera'),
                        onTap: () async {
                          await _pickImageFromCamera();
                        },
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
                      const SizedBox(height: 16),
                      GestureDetector(
                        key: const Key('GestureDetectorGallery'),
                        onTap: () async {
                          // await _pickImageFromGallery();
                          await _showImagePickerModal();
                        },
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
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('Deteksi Button'),
                onPressed: _isLoading ? null : _uploadAndDetect,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal[900]),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  minimumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 50)),
                ),
                child: _isLoading
                    ? AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Loading...',
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        repeatForever: true,
                        pause: const Duration(
                            milliseconds: 300), // Pause between repetitions
                      )
                    : const Text('Deteksi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              if (_result.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hasil Deteksi:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _result.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              Icons.check_circle,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              _result[index],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Rekomendasi Masakan'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (_matchingProducts.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: _matchingProducts.map<Widget>((product) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 10), // Spacing between cards
                        child: DietCardSmall(
                          title: product['title'] ??
                              'No Title', // Added null check
                          image_src: product['image_src'] ??
                              'No Images', // Added null check
                          onTap: () {
                            // Handle tap action here, if needed
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => RecipeDetailModal(
                                  product: Product.fromJson(product)),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
