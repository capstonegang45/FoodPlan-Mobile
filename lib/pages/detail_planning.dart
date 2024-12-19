// ignore_for_file: unnecessary_string_interpolations

// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:food_plan/models/produk.dart';
// import 'package:food_plan/widgets/recipe_modal.dart';


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
        backgroundColor: Colors.teal[900],
        title: const Text("Detail Rencana", style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20
        )),
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
                  color: Colors.teal[900],
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
                  TabBar(
                    indicatorColor: Colors.teal[900],
                    labelColor: Colors.teal[900],
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'Informasi Rencana'),
                      Tab(text: 'Rekomendasi Makanan'),
                      Tab(text: 'Aktivitas'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        InformasiRencana(informasi: informasi),
                        RekomendasiMakanan(rekomendasiMakanan: rekomendasiMakanan),
                        Aktivitas(aktivitas: aktivitas),
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

class InformasiRencana extends StatelessWidget {
  final List<String> informasi;

  const InformasiRencana({super.key, required this.informasi});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Deskripsi:', informasi[0]),
          _buildInfoSection('Tingkat Kesulitan:', informasi[1]),
          _buildInfoSection('Durasi:', informasi[2]),
          _buildInfoSection('Komitmen:', informasi[3]),
          _buildInfoSection('Pilih Diet ini Jika:', informasi[4]),
          _buildInfoSection('Apa yang akan dilakukan?', informasi[5]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

class RekomendasiMakanan extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> rekomendasiMakanan;

  const RekomendasiMakanan({super.key, required this.rekomendasiMakanan});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  onTap: () {
                    // Implement modal or navigation to detail
                  },
                );
              // ignore: unnecessary_to_list_in_spreads
              }).toList(),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class Aktivitas extends StatelessWidget {
  final String aktivitas;

  const Aktivitas({super.key, required this.aktivitas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        aktivitas,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }
}
