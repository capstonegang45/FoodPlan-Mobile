// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/widgets/recipe_modal.dart';

class DetailRencanaPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> informasi;
  final Map<String, List<Map<String, dynamic>>> rekomendasiMakanan;
  final String aktivitas;

  const DetailRencanaPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.informasi,
    required this.rekomendasiMakanan,
    required this.aktivitas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 91, 75),
        title: const Text("Detail Rencana"),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 15, left: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 68, 91, 75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Color.fromARGB(255, 68, 91, 75),
                    labelColor: Color.fromARGB(255, 68, 91, 75),
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Informasi Rencana'),
                      Tab(text: 'Rekomendasi Makanan'),
                      Tab(text: 'Aktivitas'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab Informasi Rencana
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Deskripsi
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Deskripsi:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      '${informasi[0]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              // Kesulitan
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tingkat Kesulitan:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${informasi[1]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              // Durasi
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Durasi:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${informasi[2]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              // Komitmen
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Komitmen:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${informasi[3]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              // Pilih
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pilih Diet ini Jika:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${informasi[4]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              // Lakukan
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Apa yang akan dilakukan?',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${informasi[5]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tab Rekomendasi Makanan
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: rekomendasiMakanan.entries.map((entry) {
                              final waktu = entry.key;
                              final rekomendasiList = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rekomendasi $waktu'.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...rekomendasiList.map((item) {
                                    final imageSrc = item['images_src'];
                                    final title = item['title'];
                                    final description = item['description'];
                                    final ingredients = item['ingredients'];
                                    final steps = item['steps'];
                                    final id = item['id'];
                                    final fat = item['fat'];
                                    final carbohidrat = item['carbohidrat'];
                                    final protein = item['protein'];
                                    final categoryId = item['categoryId'];
                                    final categoryName = item['categoryName'];

                                    return GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return RecipeDetailModal(
                                              product: Product(
                                                id: id,
                                                title: title,
                                                description: description,
                                                ingredients: ingredients ?? '',
                                                steps: steps ?? '',
                                                image_src: imageSrc,
                                                carbohidrat: carbohidrat ?? 0,
                                                protein: protein ?? 0,
                                                fat: fat ?? 0,
                                                categoryId: categoryId ?? 0,
                                                categoryName:
                                                    categoryName ?? '',
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.memory(
                                                  base64Decode(
                                                      imageSrc.split(',').last),
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        title,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        description,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  // ignore: unnecessary_to_list_in_spreads
                                  }).toList(),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }).toList(),
                          ),
                        ),

                        // Tab Aktivitas
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            aktivitas,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
