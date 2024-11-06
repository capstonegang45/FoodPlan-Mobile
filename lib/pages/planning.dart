import 'package:flutter/material.dart';
import 'detail_planning.dart';
import '../widgets/custom_bottom_nav.dart';

class RencanaPage extends StatefulWidget {
  @override
  _RencanaPageState createState() => _RencanaPageState();
}

class _RencanaPageState extends State<RencanaPage> {
  int _selectedIndex = 2;

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
          // Tetap di halaman Rencana
          break;
      }
    }
  }

  final List<String> dietPlans = [
    'Balanced Meal Plan',
    'Everyday Wellness Plan',
    'Lean & Clean Diet',
    'SlimFit Program',
    'Mother\'s Glow Plan',
    'Nurture & Nourish',
  ];

  final List<String> dietImages = [
    'assets/img/balanced_meal.png',
    'assets/img/wellness_plan.png',
    'assets/img/lean_clean.png',
    'assets/img/slimfit.png',
    'assets/img/mothers_glow.png',
    'assets/img/nurture_nourish.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FOODPLAN APP',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 68, 91, 75),
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
                  FilterButton(label: 'Semua', isSelected: true),
                  SizedBox(
                    width: 8,
                  ),
                  FilterButton(label: 'Diet Normal', isSelected: false),
                  SizedBox(
                    width: 8,
                  ),
                  FilterButton(label: 'Diet Berat Badan', isSelected: false),
                  SizedBox(
                    width: 8,
                  ),
                  FilterButton(label: 'Diet Olahraga', isSelected: false),
                  SizedBox(
                    width: 8,
                  ),
                  FilterButton(label: 'Diet Sakit', isSelected: false),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Diet Plan Cards
            Expanded(
              child: ListView.builder(
                itemCount: dietPlans.length,
                itemBuilder: (context, index) {
                  return DietPlanCard(
                    title: dietPlans[index],
                    imagePath: dietImages[index],
                    onTap: () {
                      // Navigate to DetailRencanaPage with title and imagePath
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRencanaPage(
                            title: dietPlans[index],
                            imagePath: dietImages[index],
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

// Widget for Filter Buttons
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      selected: isSelected,
      onSelected: (selected) {
        // Handle selection logic if needed
      },
      selectedColor: Color.fromARGB(255, 68, 91, 75),
      backgroundColor: Colors.grey[200],
    );
  }
}

// Widget for Diet Plan Card with onTap callback
class DietPlanCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const DietPlanCard({
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
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 68, 91, 75),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: TextStyle(
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
