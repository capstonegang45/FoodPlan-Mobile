import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_plan/pages/profile_setting.dart';
import 'package:food_plan/widgets/custom_bottom_nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/img/icons8.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ilham Hatta Manggala',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'admin123@gmail.com',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Banner
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 1.0,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
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

            // Rekomendasi Diet Normal section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'REKOMENDASI DIET NORMAL',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 700,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6, // Number of items in the grid
                itemBuilder: (context, index) {
                  return DietCard(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => RecipeDetailModal(),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 2),

            // Rekomendasi Diet Lainnya section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "REKOMENDASI DIET LAINNYA",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'assets/img/makan.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CAPCAY BROKOLI",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Sajian capcay yang biasanya hadir dengan beragam jenis sayuran juga bisa dibuat dengan satu macam...",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

// DietCard widget with onTap functionality
class DietCard extends StatelessWidget {
  final VoidCallback onTap;

  DietCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  'assets/img/makan.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 68, 91, 75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Capcay Brokoli',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// RecipeDetailModal widget for the detailed view
class RecipeDetailModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: DefaultTabController(
              length: 3, // Jumlah tab
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/img/makan.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CAPCAY BROKOLI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sajian capcay yang biasanya hadir dengan beragam jenis sayuran juga bisa dibuat dengan satu macam sayuran saja lho. Rasanya pun tak kalah sedap dengan versi pada umumnya. Yuk, coba!',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),

                  // TabBar untuk navigasi tab
                  TabBar(
                    labelColor: Color.fromARGB(255, 68, 91, 75),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color.fromARGB(255, 68, 91, 75),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    tabs: [
                      Tab(
                        child: Text(
                          "Bahan",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Informasi",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Cara Membuat",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),

                  // TabBarView untuk konten masing-masing tab
                  Container(
                    height:
                        300, // Batasi tinggi TabBarView agar scroll bekerja dengan baik
                    child: TabBarView(
                      children: [
                        // Konten Tab "Bahan" dengan scroll
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bahan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '• 1 Kuntum brokoli ukuran besar\n'
                                  '• 2 Buah tahu iris bulat\n'
                                  '• 1 Tangkai daun bawang potong-potong\n'
                                  '• 2 Siung bawang putih cincang\n'
                                  '• 2 sdm kecap asin\n'
                                  '• 1 sdt minyak wijen\n'
                                  '• 1 sdm saus tiram\n'
                                  '• Garam, merica, dan gula secukupnya\n',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Konten Tab "Informasi"
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Informasi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                // Karbohidrat
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Karbohidrat',
                                        style: TextStyle(fontSize: 14)),
                                    Text('200', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: 0.8,
                                  backgroundColor: Colors.grey[300],
                                  color: Color.fromARGB(255, 68, 91, 75),
                                  minHeight: 6,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                SizedBox(height: 16),
                                // Protein
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Protein',
                                        style: TextStyle(fontSize: 14)),
                                    Text('80', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: 0.4,
                                  backgroundColor: Colors.grey[300],
                                  color: Color.fromARGB(255, 68, 91, 75),
                                  borderRadius: BorderRadius.circular(10),
                                  minHeight: 6,
                                ),
                                SizedBox(height: 16),
                                // Lemak
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Lemak',
                                        style: TextStyle(fontSize: 14)),
                                    Text('120', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                LinearProgressIndicator(
                                  value: 0.6,
                                  backgroundColor: Colors.grey[300],
                                  color: Color.fromARGB(255, 68, 91, 75),
                                  borderRadius: BorderRadius.circular(10),
                                  minHeight: 6,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Konten Tab "Cara Membuat" dengan scroll
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cara Membuat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '1. Potong-potong brokoli dan tahu.\n'
                                  '2. Tumis bawang putih hingga harum.\n'
                                  '3. Masukkan brokoli, tahu, dan bumbu lainnya.\n'
                                  '4. Aduk rata dan masak hingga matang.\n'
                                  '5. Sajikan hangat.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
