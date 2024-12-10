class Validasi {
  final int usia;
  final int tBadan;
  final int bBadan;
  final String jKelamin;
  final String riwayat;
  final String? tipeDiet;

  // Constructor
  Validasi({
    required this.usia,
    required this.tBadan,
    required this.bBadan,
    required this.jKelamin,
    required this.riwayat,
    this.tipeDiet,
  });

  // Factory method untuk membuat objek dari JSON
  factory Validasi.fromJson(Map<String, dynamic> json) {
    return Validasi(
      usia: json['usia'],
      bBadan: json['bBadan'],
      tBadan: json['tBadan'],
      jKelamin: json['jKelamin'],
      riwayat: json['riwayat'],
      tipeDiet: json['tipeDiet'],
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'usia': usia,
      'bBadan': bBadan,
      'tBadan': tBadan,
      'jKelamin': jKelamin,
      'riwayat': riwayat,
      'tipeDiet': tipeDiet,
    };
  }
}
