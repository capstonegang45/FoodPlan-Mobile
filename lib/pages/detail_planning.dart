import 'package:flutter/material.dart';

class DetailRencanaPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String informasi;
  final String rekomendasiMakanan;
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(informasi,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(rekomendasiMakanan,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(aktivitas,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700])),
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
