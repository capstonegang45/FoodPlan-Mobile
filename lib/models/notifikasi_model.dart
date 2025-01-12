class NotifikasiModel {
  final int id;
  final int usersId;
  final String? pagi;
  final String? siang;
  final String? malem;

  // Constructor
  NotifikasiModel({
    required this.id,
    required this.usersId,
    this.pagi,
    this.siang,
    this.malem
  });

  // Factory method untuk membuat objek dari JSON
  factory NotifikasiModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiModel(
      id: json['id'],
      usersId: json['usersId'],
      pagi: json['pagi'],
      siang: json['siang'],
      malem: json['malem']
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usersId': usersId,
      'pagi': pagi,
      'siang': siang,
      'malem': malem,
    };
  }
}
