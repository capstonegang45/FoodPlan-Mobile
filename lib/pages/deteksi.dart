// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
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

  // DeteksiHelper get _helper => widget.helper;

  Future<void> _pickImageFromGallery() async {
    final image = await _helper.pickImageFromGallery();
    setState(() {
      _image = image;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final image = await _helper.pickImageFromCamera();
    setState(() {
      _image = image;
    });
  }

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
      _result = [];
      _matchingProducts = []; // Clear previous product list
    });

    try {
      final result = await _helper.uploadAndDetect(_image!);
      setState(() {
        List<String> detections = result['detections'] as List<String>;

        // Hapus duplikasi dengan Set, lalu ubah kembali menjadi List
        _result = detections.toSet().toList();
        _matchingProducts = result['products']; // Update products
      });
    } catch (e) {
      // Menggunakan ScaffoldMessenger.of(context) agar toastification tampil di atas semua widget yang menggunakan Scaffold

      await showCustomToastNotification(
        context: context,
        title: 'Error',
        message: "Terjadi kesalahan saat mendapatkan hasil deteksi",
        type: ToastificationType.error
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                                size: 40,
                                color: Color.fromARGB(255, 68, 91, 75)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          key: const Key('GestureDetectorGallery'),
                          onTap: () async {
                            await _pickImageFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: const Icon(Icons.photo,
                                size: 40,
                                color: Color.fromARGB(255, 68, 91, 75)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _uploadAndDetect,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.teal[900]),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 50)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
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
          )),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
