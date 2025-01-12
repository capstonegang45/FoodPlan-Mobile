// ignore_for_file: unnecessary_string_interpolations
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/widgets/produk_list.dart';
import 'package:food_plan/widgets/recipe_modal.dart';

class DetailRencanaPage extends StatefulWidget {
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
  State<DetailRencanaPage> createState() => _DetailRencanaPageState();
}

class _DetailRencanaPageState extends State<DetailRencanaPage> {
  String defaultImageBase64 = '';

  @override
  void initState() {
    super.initState();
    convertImageToBase64().then((base64) {
      setState(() {
        defaultImageBase64 = base64;
      });
    });
  }

  Future<String> convertImageToBase64() async {
    // Baca file dari assets
    final ByteData imageData = await rootBundle.load('assets/img/slimfit.png');
    // Konversi data ke list of bytes
    final Uint8List bytes = imageData.buffer.asUint8List();
    // Encode ke string base64
    final String base64Image = base64Encode(bytes);
    // Tambahkan prefix untuk gambar base64
    return 'data:image/png;base64,$base64Image';
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    // Tentukan apakah imagePath adalah Base64 atau URL
    if (widget.imagePath.startsWith('data:image')) {
      // Jika gambar dalam format base64
      try {
        final bytes = base64Decode(widget.imagePath.split(',').last);
        imageProvider = MemoryImage(bytes); // Gunakan MemoryImage untuk base64
      } catch (e) {
        imageProvider =
            const AssetImage('assets/img/slimfit.png'); // Default jika gagal
      }
    } else if (widget.imagePath.startsWith('http')) {
      // Jika gambar adalah URL
      imageProvider = NetworkImage(widget.imagePath);
    } else {
      // Jika tidak ada gambar, gunakan gambar default
      imageProvider = const AssetImage('assets/img/slimfit.png');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
          "Detail Rencana",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/rencana');
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              widget.imagePath == 'No Images'
                  ? (defaultImageBase64.isNotEmpty
                      ? Image.memory(
                          base64Decode(defaultImageBase64.split(',').last),
                          fit: BoxFit.cover,
                          height: 172.7,
                          width: double.infinity,
                        )
                      : const SizedBox()) // Gunakan base64 jika ada fallback
                  : Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      height: 172.7,
                      width: double.infinity,
                    ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 15, left: 10),
                decoration: BoxDecoration(
                  color: Colors.teal[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.title,
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
                        InformasiRencana(informasi: widget.informasi),
                        RekomendasiMakanan(
                            rekomendasiMakanan: widget.rekomendasiMakanan),
                        Aktivitas(aktivitas: widget.aktivitas),
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
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Colors.black),
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
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              ...rekomendasiList.map((item) {
                return ProductListItem(
                  title: item['title'],
                  imageSrc: item['images_src'] ?? '',
                  description: item['description'],
                  onTap: () {
                    // Navigasi ke modal
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => RecipeDetailModal(
                        product: Product(
                          id: item['id'],
                          title: item['title'],
                          image_src: item['images_src'] ?? '',
                          description: item['description'],
                          ingredients: item['ingredients'],
                          steps: item['steps'],
                          carbohidrat: item['carbohidrat'],
                          protein: item['protein'],
                          fat: item['fat'],
                          categoryId: item['categoryId'],
                          categoryName: item['categoryName'],
                        ),
                      ),
                    );
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
    // Memecah aktivitas berdasarkan tanda titik koma ';' dan menyimpan dalam list
    final aktivitasList = aktivitas.split(';');

    // Membuat map untuk mengelompokkan aktivitas berdasarkan waktu
    Map<String, List<String>> aktivitasMap = {};

    for (var entry in aktivitasList) {
      if (entry.trim().isNotEmpty) {
        // Memisahkan berdasarkan kata kunci seperti Pagi, Siang, Sore, Malam
        final parts = entry.split(':');
        if (parts.length == 2) {
          final timeOfDay = parts[0].trim();
          final activity = parts[1].trim();

          // Memasukkan aktivitas ke dalam map berdasarkan waktu (Pagi, Siang, dll.)
          if (!aktivitasMap.containsKey(timeOfDay)) {
            aktivitasMap[timeOfDay] = [];
          }
          aktivitasMap[timeOfDay]!.add(activity);
        }
      }
    }

    // Menyusun widget berdasarkan waktu dan aktivitas
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: aktivitasMap.entries.map((entry) {
          // Menampilkan waktu (Pagi, Siang, dll.) dan aktivitas-aktivitas yang relevan
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key
                    .toUpperCase(), // Menampilkan waktu (Pagi, Siang, dll.)
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              ...entry.value.map(
                (activity) => Text(
                  '• $activity', // Menampilkan aktivitas dengan bullet
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10), // Memberikan jarak antar waktu
            ],
          );
        }).toList(),
      ),
    );
  }
}
