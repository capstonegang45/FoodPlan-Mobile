import 'package:food_plan/models/kegiatan_model.dart';
import 'package:food_plan/models/produk.dart';

class Plannings {
  final int id;
  final String nama;
  final int categoryId;
  final String description;
  final String? categoryName;
  final String? images;
  final List<DetailPlanning> details;
  final List<Product> produk;
  final List<Kegiatan> aktivitas;

  // Constructor
  Plannings({
    required this.id,
    required this.nama,
    required this.categoryId,
    required this.description,
    this.images,
    this.categoryName,
    required this.details,
    required this.produk,
    required this.aktivitas,
  });

  // Factory method untuk membuat objek dari JSON
  factory Plannings.fromJson(Map<String, dynamic> json) {
    return Plannings(
      id: json['id'],
      categoryId: json['categoryId'],
      nama: json['nama'],
      description: json['description'],
      categoryName: json['categoryName'],
      images: json['image'],
      details: (json['details'] as List<dynamic>)
          .map((e) => DetailPlanning.fromJson(e as Map<String, dynamic>))
          .toList(),
      produk: (json['rekomendasiMakanan'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      aktivitas: (json['aktivitas'] as List<dynamic>)
          .map((e) => Kegiatan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'nama': nama,
      'description': description,
      'categoryName': categoryName,
      'image': images,
      'details': details.map((e) => e.toJson()).toList(),
      'rekomendasiMakanan': produk.map((e) => e.toJson()).toList(),
      'aktivitas': aktivitas.map((e) => e.toJson()).toList(),
    };
  }
}

class DetailPlanning {
  final int planningId;
  final String durasi;
  final String kesulitan;
  final String komitmen;
  final String pilih;
  final String lakukan;

  DetailPlanning({
    required this.planningId,
    required this.durasi,
    required this.kesulitan,
    required this.komitmen,
    required this.pilih,
    required this.lakukan,
  });

  // Factory method untuk deserialisasi JSON
  factory DetailPlanning.fromJson(Map<String, dynamic> json) {
    return DetailPlanning(
      planningId: json['planning_id'],
      durasi: json['durasi'],
      kesulitan: json['kesulitan'],
      komitmen: json['komitmen'],
      pilih: json['pilih'],
      lakukan: json['lakukan'],
    );
  }

  // Method untuk serialisasi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'planning_id': planningId,
      'durasi': durasi,
      'kesulitan': kesulitan,
      'komitmen': komitmen,
      'pilih': pilih,
      'lakukan': lakukan,
    };
  }
}
