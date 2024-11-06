import 'package:flutter/material.dart';

class DetailRencanaPage extends StatelessWidget {
  final String title;
  final String imagePath;

  DetailRencanaPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 68, 91, 75),
        title: Text("Detail Rencana"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Column(
        children: [
          // Image with title overlay
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
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(bottom: 15, left: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 68, 91, 75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // TabBar and TabBarView for content
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Color.fromARGB(255, 68, 91, 75),
                    labelColor: Color.fromARGB(255, 68, 91, 75),
                    unselectedLabelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 12), // Adjust font size as needed
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: 4.0), // Adjust padding
                    tabs: [
                      Tab(text: 'Informasi Rencana'),
                      Tab(text: 'Rekomendasi Makanan'),
                      Tab(text: 'Aktivitas'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content for Informasi Rencana tab
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pelajari bagaimana merencanakan dan menjalankan pola makan seimbang dengan fokus pada makro dan mikro nutrisi. Rencana ini akan membantu Anda mencapai kesehatan optimal dan meningkatkan performa fisik secara berkelanjutan. Dari kontrol porsi hingga kombinasi makanan yang tepat, Anda akan belajar cara menjaga keseimbangan yang mendukung gaya hidup sehat.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Konsultasikan dengan dokter Anda sebelum memulai rencana ini dengan aman. Kami tidak bertanggung jawab atas cedera atau masalah kesehatan yang mungkin terjadi selama menjalankan program ini.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Durasi: 28 hari\nTingkat Kesulitan: Pemula\nKomitmen: Harian',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Pilih rencana ini jika:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '• Anda baru memulai pola makan seimbang dan membutuhkan panduan.\n'
                                  '• Anda ingin meningkatkan kualitas makanan sehari-hari dengan cara yang mudah diikuti.\n'
                                  '• Anda ingin mencapai tujuan kesehatan atau kebugaran tertentu dengan pola makan yang teratur.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Apa yang akan Anda lakukan:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '• Belajar menyusun menu makanan yang seimbang sesuai kebutuhan nutrisi Anda.\n'
                                  '• Mengatur porsi makanan untuk mencapai tujuan kesehatan Anda.\n'
                                  '• Memahami pentingnya variasi makanan yang kaya akan nutrisi dalam setiap kali makan.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Content for Rekomendasi Makanan tab
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Text(
                              'Rekomendasi makanan yang cocok untuk diet ini.',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                        ),
                        // Content for Aktivitas tab
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Text(
                              'Aktivitas atau olahraga yang direkomendasikan untuk mendukung diet ini.',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
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
        ],
      ),
    );
  }
}
