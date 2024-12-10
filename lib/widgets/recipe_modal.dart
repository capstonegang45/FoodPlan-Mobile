import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:food_plan/models/produk.dart';

class RecipeDetailModal extends StatelessWidget {
  final Product product;

  const RecipeDetailModal({super.key, required this.product});

  // Fungsi untuk membuat bar nutrisi dengan nilai yang disesuaikan
  Widget _buildNutritionRow(String label, double value, double maxValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value / maxValue,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 68, 91, 75), // Warna progress bar
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Text("${value.toInt()} g"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Decode base64 image if available
    Uint8List? bytes;
    // ignore: unnecessary_null_comparison
    if (product.image_src != null && product.image_src != 'No Images') {
      try {
        bytes = base64Decode(product.image_src.split(',').last);
      } catch (e) {
        bytes = null;
      }
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              // Header dengan warna amber
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 70, 34), // Warna baru
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Konten dengan padding
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const SizedBox(height: 10),
                    // Image
                    bytes == null
                        ? const Icon(Icons.image,
                            size: 100,
                            color: Colors.grey) // Placeholder if no image
                        : Image.memory(
                            bytes,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                    const SizedBox(height: 10),
                    Text(product.description),
                    const SizedBox(height: 10),
                    // TabBar and TabBarView
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TabBar(
                            indicatorColor: Color.fromARGB(255, 34, 70, 34),
                            labelColor: Color.fromARGB(255, 34, 70, 34),
                            tabs: [
                              Tab(text: 'Bahan'),
                              Tab(text: 'Informasi'),
                              Tab(text: 'Cara Membuat'),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            child: TabBarView(
                              children: [
                                // Tab Bahan
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.ingredients),
                                  ),
                                ),
                                // Tab Informasi
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildNutritionRow(
                                            "Karbohidrat",
                                            product.carbohidrat.toDouble(),
                                            200.0),
                                        const SizedBox(height: 10),
                                        _buildNutritionRow("Protein",
                                            product.protein.toDouble(), 100.0),
                                        const SizedBox(height: 10),
                                        _buildNutritionRow("Lemak",
                                            product.fat.toDouble(), 150.0),
                                      ],
                                    ),
                                  ),
                                ),
                                // Cara Membuat
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.steps),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
