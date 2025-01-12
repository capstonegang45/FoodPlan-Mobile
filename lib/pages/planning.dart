// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_plan/provider/rencana_providers.dart';
import 'package:provider/provider.dart';
import 'detail_planning.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RencanaPage extends StatefulWidget {
  const RencanaPage({super.key});

  @override
  _RencanaPageState createState() => _RencanaPageState();
}

class _RencanaPageState extends State<RencanaPage> {
  int _selectedIndex = 3;
  String selectedCategory = 'Semua';
  String defaultImageBase64 = '';

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RencanaProvider>(context, listen: false);
    if (provider.plans.isEmpty) {
      provider.loadPlans(); // Hanya panggil jika data belum ada
    }
    convertImageToBase64().then((base64) {
      setState(() {
        defaultImageBase64 = base64;
      });
    });
  }

  Future<String> convertImageToBase64() async {
    // Baca file dari assets
    final ByteData imageData = await rootBundle.load('assets/img/slimfit.png');
    // Konversi data ke list of bytes
    final Uint8List bytes = imageData.buffer.asUint8List();
    // Encode ke string base64
    final String base64Image = base64Encode(bytes);
    // Tambahkan prefix untuk gambar base64
    return 'data:image/png;base64,$base64Image';
  }

  // Filtering plans based on category
  List<dynamic> _filterPlans(List<dynamic> plans) {
    if (selectedCategory == 'Semua') {
      return plans;
    } else {
      return plans
          .where((plan) => plan['categoryName'] == selectedCategory)
          .toList();
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
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
          Navigator.pushReplacementNamed(context, '/deteksi');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/chatbot');
          break;
        case 3:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RencanaProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FOODPLAN APP',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal[900],
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading...',
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900]),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
                pause: const Duration(milliseconds: 300),
              ),
            ),
          );
        } else if (provider.error != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FOODPLAN APP',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal[900],
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(child: Text('Error: ${provider.error}')),
          );
        } else if (provider.plans.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FOODPLAN APP',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal[900],
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: const Center(child: Text('Tidak ada data tersedia.')),
          );
        } else {
          final filteredPlans = _filterPlans(provider.plans);

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FOODPLAN APP',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.teal[900],
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterButton(
                            label: 'Semua',
                            isSelected: selectedCategory == 'Semua',
                            onTap: _onCategorySelected),
                        const SizedBox(width: 8),
                        FilterButton(
                            label: 'Diet Normal',
                            isSelected: selectedCategory == 'Diet Normal',
                            onTap: _onCategorySelected),
                        const SizedBox(width: 8),
                        FilterButton(
                            label: 'Diet Berat Badan',
                            isSelected: selectedCategory == 'Diet Berat Badan',
                            onTap: _onCategorySelected),
                        const SizedBox(width: 8),
                        FilterButton(
                            label: 'Diet Sport',
                            isSelected: selectedCategory == 'Diet Sport',
                            onTap: _onCategorySelected),
                        const SizedBox(width: 8),
                        FilterButton(
                            label: 'Diet Khusus',
                            isSelected: selectedCategory == 'Diet Khusus',
                            onTap: _onCategorySelected),
                        const SizedBox(width: 8),
                        FilterButton(
                            label: 'Diet 2 Nyawa',
                            isSelected: selectedCategory == 'Diet 2 Nyawa',
                            onTap: _onCategorySelected),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = filteredPlans[index];
                        return DietPlanCard(
                          title: plan['nama'] ??
                              '', // Default to empty string if null
                          imagePath: plan['image'] ??
                              base64Decode(defaultImageBase64
                                  .split(',')
                                  .last), // Default image if null
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailRencanaPage(
                                  title: plan['nama'] ??
                                      '', // Default to empty string if null
                                  imagePath: plan['image'] ??
                                      base64Decode(defaultImageBase64
                                          .split(',')
                                          .last), // Default image if null
                                  aktivitas: (plan['aktivitas'] as List?)
                                          ?.map(
                                              (item) => item['aktivitas'] ?? '')
                                          .join(', ') ??
                                      '', // Safely join aktivitas or default to empty string
                                  informasi: [
                                    plan['description'] ??
                                        '', // Default to empty string if null
                                    plan['details']?[0]['kesulitan'] ??
                                        '', // Safe access for null
                                    plan['details']?[0]['durasi'] ??
                                        '', // Safe access for null
                                    plan['details']?[0]['komitmen'] ??
                                        '', // Safe access for null
                                    plan['details']?[0]['pilih'] ??
                                        '', // Safe access for null
                                    plan['details']?[0]['lakukan'] ??
                                        '', // Safe access for null
                                  ],
                                  rekomendasiMakanan: {
                                    "Pagi": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']?['Pagi']
                                                    as List? ??
                                                [])
                                            .map((item) => {
                                                  'id': item['id'] ?? '',
                                                  'title': item['title'] ?? '',
                                                  'description':
                                                      item['description'] ?? '',
                                                  'category_id':
                                                      item['category_id'] ?? '',
                                                  'ingredients':
                                                      item['ingredients'] ?? '',
                                                  'steps': item['steps'] ?? '',
                                                  'fat': item['fat'] ?? '',
                                                  'carbohidrat':
                                                      item['carbohidrat'] ?? '',
                                                  'protein':
                                                      item['protein'] ?? '',
                                                  'categoryId':
                                                      item['category_id'] ?? '',
                                                  'categoryName':
                                                      item['category_name'] ??
                                                          '',
                                                  'images_src':
                                                      item['images_src'] ?? '',
                                                })),
                                    "Siang": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']?['Siang']
                                                    as List? ??
                                                [])
                                            .map((item) => {
                                                  'id': item['id'] ?? '',
                                                  'title': item['title'] ?? '',
                                                  'description':
                                                      item['description'] ?? '',
                                                  'category_id':
                                                      item['category_id'] ?? '',
                                                  'ingredients':
                                                      item['ingredients'] ?? '',
                                                  'steps': item['steps'] ?? '',
                                                  'fat': item['fat'] ?? '',
                                                  'carbohidrat':
                                                      item['carbohidrat'] ?? '',
                                                  'protein':
                                                      item['protein'] ?? '',
                                                  'categoryId':
                                                      item['category_id'] ?? '',
                                                  'categoryName':
                                                      item['category_name'] ??
                                                          '',
                                                  'images_src':
                                                      item['images_src'] ?? '',
                                                })),
                                    "Malam": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']?['Malam']
                                                    as List? ??
                                                [])
                                            .map((item) => {
                                                  'id': item['id'] ?? '',
                                                  'title': item['title'] ?? '',
                                                  'description':
                                                      item['description'] ?? '',
                                                  'category_id':
                                                      item['category_id'] ?? '',
                                                  'ingredients':
                                                      item['ingredients'] ?? '',
                                                  'steps': item['steps'] ?? '',
                                                  'fat': item['fat'] ?? '',
                                                  'carbohidrat':
                                                      item['carbohidrat'] ?? '',
                                                  'protein':
                                                      item['protein'] ?? '',
                                                  'categoryId':
                                                      item['category_id'] ?? '',
                                                  'categoryName':
                                                      item['category_name'] ??
                                                          '',
                                                  'images_src':
                                                      item['images_src'] ?? '',
                                                })),
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
        }
      },
    );
  }
}

// Updated FilterButton with onTap callback
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<String> onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      iconTheme: IconThemeData(
        color: isSelected ? Colors.white : Colors.black,
      ),
      checkmarkColor: isSelected ? Colors.white : Colors.black,
      label: Text(label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      selected: isSelected,
      onSelected: (_) {
        onTap(label);
      },
      selectedColor: Colors.teal[900],
      backgroundColor: Colors.grey[200],
    );
  }
}

class DietPlanCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const DietPlanCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    // Tentukan apakah image_src adalah Base64 atau URL
    if (imagePath.startsWith('data:image')) {
      try {
        bytes = base64Decode(imagePath.split(',').last);
      } catch (e) {
        // Jika decoding gagal, set bytes ke null
        bytes = null;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: bytes != null
                  ? Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    )
                  : imagePath.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: imagePath,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const Icon(Icons.image, size: 50),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.teal[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
