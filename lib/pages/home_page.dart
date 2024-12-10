import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_plan/helpers/beranda_helper.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/widgets/custom_bottom_nav.dart';
import 'package:food_plan/widgets/custom_btn.dart';
import 'package:food_plan/widgets/produk_list.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:food_plan/widgets/diet_card.dart';
import 'package:food_plan/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData =
        getUserProfileAndProducts(); // Mengambil data dengan userId = 1
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/deteksi');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/rencana');
          break;
      }
    }
  }

  final List<String> bannerImages = [
    'assets/img/1.png',
    'assets/img/2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: FutureBuilder<Map<String, dynamic>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading data');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            }

            final user =
                User.fromJson(snapshot.data!['user']); // Ambil data user
            // Ambil data produk

            final avatarBytes = base64Decode(user.avatar!.split(',')[1]);

            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: MemoryImage(avatarBytes),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nama,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 1.0,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            // Menampilkan Produk
            FutureBuilder<Map<String, dynamic>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading products'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No products available'));
                }

                final matchingProducts = List<Map<String, dynamic>>.from(
                  snapshot.data!['products']['matching_products'] ?? [],
                ).map((e) => Product.fromJson(e)).toList();

                final otherProducts = List<Map<String, dynamic>>.from(
                  snapshot.data!['products']['other_products'] ?? [],
                ).map((e) => Product.fromJson(e)).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        matchingProducts.isNotEmpty
                            ? 'REKOMENDASI RESEP ${matchingProducts[0].categoryName.toUpperCase()}'
                            : 'Rekomendasi Resep',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: matchingProducts.length,
                      itemBuilder: (context, index) {
                        final product = matchingProducts[index];
                        return DietCard(
                          title: product.title,
                          image_src: product.image_src,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  RecipeDetailModal(product: product),
                            );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'REKOMENDASI DIET LAINNYA',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          otherProducts.length > 10 ? 10 : otherProducts.length,
                      itemBuilder: (context, index) {
                        final product = otherProducts[index];
                        return ProductListItem(
                          title: product.title,
                          description: product.description,
                          imageSrc: product.image_src,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  RecipeDetailModal(product: product),
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomButton(
                        label: 'Lihat Resep Lainnya',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/fullresep');
                        },
                      ),
                    ),
                  ],
                );
              },
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
}
