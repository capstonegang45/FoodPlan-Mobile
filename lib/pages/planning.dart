import 'package:flutter/material.dart';
import 'package:food_plan/helpers/planning_helper.dart';
import 'detail_planning.dart';
import '../widgets/custom_bottom_nav.dart';

class RencanaPage extends StatefulWidget {
  const RencanaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RencanaPageState createState() => _RencanaPageState();
}

class _RencanaPageState extends State<RencanaPage> {
  int _selectedIndex = 2;
  String selectedCategory = 'Semua';
  late Future<List<dynamic>> _plansFuture;

  @override
  void initState() {
    super.initState();
    // Fetch data using PlanningHelper
    _plansFuture = PlanningHelper().fetchPlans();
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
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FOODPLAN APP',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 68, 91, 75),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _plansFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data tersedia.'));
          } else {
            // Filter plans
            final filteredPlans = _filterPlans(snapshot.data!);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter buttons
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
                        // Tambahkan kategori lainnya sesuai kebutuhan
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Diet Plan Cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = filteredPlans[index];
                        return DietPlanCard(
                          title: plan['nama'],
                          imagePath: plan['image'] ?? 'assets/img/slimfit.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailRencanaPage(
                                  title: plan['nama'],
                                  imagePath:
                                      plan['image'] ?? 'assets/img/slimfit.png',
                                  aktivitas: (plan['aktivitas'] as List)
                                      .map((item) => item['aktivitas'])
                                      .join(', '),
                                  informasi: [
                                    plan['description'],
                                    plan['details'][0]['kesulitan'],
                                    plan['details'][0]['durasi'],
                                    plan['details'][0]['komitmen'],
                                    plan['details'][0]['pilih'],
                                    plan['details'][0]['lakukan'],
                                  ],
                                  rekomendasiMakanan: {
                                    "Pagi": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']['Pagi'] as List)
                                            .map((item) => {
                                                  'id': item['id'],
                                                  'title': item['title'],
                                                  'description':
                                                      item['description'],
                                                  'category_id':
                                                      item['category_id'],
                                                  'images_src':
                                                      item['images_src'],
                                                  'ingredients': item['ingredients'],
                                                  'steps': item['steps'],
                                                  'fat': item['fat'],
                                                  'carbohidrat': item['carbohidrat'],
                                                  'protein': item['protein'],
                                                  'categoryId': item['category_id'],
                                                  'categoryName': item['category_name'],
                                                })),
                                    "Siang": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']['Siang'] as List)
                                            .map((item) => {
                                                  'id': item['id'],
                                                  'title': item['title'],
                                                  'description':
                                                      item['description'],
                                                  'category_id':
                                                      item['category_id'],
                                                  'images_src':
                                                      item['images_src'],
                                                  'ingredients': item['ingredients'],
                                                  'steps': item['steps'],
                                                  'fat': item['fat'],
                                                  'carbohidrat': item['carbohidrat'],
                                                  'protein': item['protein'],
                                                  'categoryId': item['category_id'],
                                                  'categoryName': item['category_name'],
                                                })),
                                    "Malam": List<Map<String, dynamic>>.from(
                                        (plan['rekomendasiMakanan']['Malam'] as List)
                                            .map((item) => {
                                                  'id': item['id'],
                                                  'title': item['title'],
                                                  'description':
                                                      item['description'],
                                                  'category_id':
                                                      item['category_id'],
                                                  'images_src':
                                                      item['images_src'],
                                                  'ingredients': item['ingredients'],
                                                  'steps': item['steps'],
                                                  'fat': item['fat'],
                                                  'carbohidrat': item['carbohidrat'],
                                                  'protein': item['protein'],
                                                  'categoryId': item['category_id'],
                                                  'categoryName': item['category_name'],
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
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
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
      label: Text(label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      selected: isSelected,
      onSelected: (_) {
        onTap(label);
      },
      selectedColor: const Color.fromARGB(255, 68, 91, 75),
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
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
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
                color: const Color.fromARGB(255, 68, 91, 75),
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
