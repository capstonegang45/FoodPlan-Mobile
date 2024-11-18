import 'package:flutter/material.dart';
import 'detail_planning.dart';
import '../widgets/custom_bottom_nav.dart';

class RencanaPage extends StatefulWidget {
  const RencanaPage({super.key});

  @override
  _RencanaPageState createState() => _RencanaPageState();
}

class _RencanaPageState extends State<RencanaPage> {
  int _selectedIndex = 2;
  String selectedCategory = 'Semua';

  final List<Map<String, dynamic>> dietPlans = [
    {
      'title': 'Diet Mediterania',
      'imagePath': 'assets/img/balanced_meal.png',
      'informasi':
          'Diet Mediterania didasarkan pada pola makan tradisional dari negara-negara di sekitar Laut Mediterania. Diet ini kaya akan buah-buahan, sayuran, biji-bijian, minyak zaitun, dan protein dari ikan. Diet ini telah terbukti baik untuk kesehatan jantung dan menurunkan risiko penyakit kronis. Durasi: Bisa dilakukan dalam jangka panjang sebagai gaya hidup.Tingkat Kesulitan: Mudah hingga sedang (bahan mudah ditemukan, namun membutuhkan adaptasi pola makan baru). Komitmen: Tinggi, karena diet ini berfokus pada pola makan yang konsisten dan seimbang. Pilih Diet Ini Jika: Anda ingin menjaga kesehatan jantung, mengurangi risiko penyakit kronis, dan mengikuti diet seimbang tanpa terlalu banyak batasan. Apa yang Akan Dilakukan: Mengonsumsi banyak sayuran, buah, kacang-kacangan, minyak zaitun, serta mengurangi konsumsi daging merah dan makanan olahan.',
      'rekomendasiMakanan':
          'Sarapan: Greek yogurt dengan buah beri, kacang-kacangan, dan madu. Makan Siang: Salad sayuran dengan quinoa, zaitun, tomat, dan ayam panggang, dengan minyak zaitun sebagai dressing. Makan Malam: Ikan panggang dengan sayuran panggang seperti zucchini dan paprika, serta kentang.',
      'aktivitas':
          'Jalan kaki 30 menit sehari atau aktivitas ringan seperti yoga.',
      'category': 'Diet Normal'
    },
    {
      'title': 'Everyday Wellness Plan',
      'imagePath': 'assets/img/wellness_plan.png',
      'category': 'Diet Normal'
    },
    {
      'title': 'Lean & Clean Diet',
      'imagePath': 'assets/img/lean_clean.png',
      'category': 'Diet Normal'
    },
    {
      'title': 'SlimFit Program',
      'imagePath': 'assets/img/slimfit.png',
      'category': 'Diet Berat Badan'
    },
    {
      'title': 'Mother\'s Glow Plan',
      'imagePath': 'assets/img/mothers_glow.png',
      'category': 'Diet Dua Nyawa'
    },
    {
      'title': 'Nurture & Nourish',
      'imagePath': 'assets/img/nurture_nourish.png',
      'category': 'Diet Dua Nyawa'
    },
  ];

  List<Map<String, dynamic>> get filteredDietPlans {
    if (selectedCategory == 'Semua') {
      return dietPlans;
    } else {
      return dietPlans
          .where((plan) => plan['category'] == selectedCategory)
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
      body: Padding(
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
                      label: 'Diet Olahraga',
                      isSelected: selectedCategory == 'Diet Olahraga',
                      onTap: _onCategorySelected),
                  const SizedBox(width: 8),
                  FilterButton(
                      label: 'Diet Sakit',
                      isSelected: selectedCategory == 'Diet Sakit',
                      onTap: _onCategorySelected),
                  const SizedBox(width: 8),
                  FilterButton(
                      label: 'Diet Dua Nyawa',
                      isSelected: selectedCategory == 'Diet Dua Nyawa',
                      onTap: _onCategorySelected),

                ],
              ),
            ),
            const SizedBox(height: 10),
            // Diet Plan Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredDietPlans.length,
                itemBuilder: (context, index) {
                  final plan = filteredDietPlans[index];
                  return DietPlanCard(
                    title: plan['title'],
                    imagePath: plan['imagePath'],
                    onTap: () {
                      // Navigate to DetailRencanaPage with title and imagePath
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRencanaPage(
                            title: dietPlans[index]['title'],
                            imagePath: dietPlans[index]['imagePath'],
                            informasi: dietPlans[index]['informasi'],
                            rekomendasiMakanan: dietPlans[index]
                                ['rekomendasiMakanan'],
                            aktivitas: dietPlans[index]['aktivitas'],
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
