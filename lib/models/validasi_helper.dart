class ValidasiHelp{
  final int id;
  final int usersId;
  final int categoryId;
  final String jenisKelamin;
  final int usia;
  final int tinggiBadan;
  final int beratBadan;
  final String riwayat;

  ValidasiHelp({
    required this.id,
    required this.usersId,
    required this.categoryId,
    required this.jenisKelamin,
    required this.usia,
    required this.tinggiBadan,
    required this.beratBadan,
    required this.riwayat
  });

  factory ValidasiHelp.fromJson(Map<String, dynamic> json) {
    return ValidasiHelp(
      id: json['id'],
      usersId: json['users_id'],
      categoryId: json['category_id'],
      jenisKelamin: json['jenis_kelamin'],
      usia: json['usia'],
      tinggiBadan: json['tinggi_badan'],
      beratBadan: json['berat_badan'],// Dapat null, jadi tidak perlu required
      riwayat: json['riwayat'],// Dapat null, jadi tidak perlu required
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usersId': usersId,
      'categoryId': categoryId,
      'jenisKelamin': jenisKelamin,
      'usia': usia,
      'tinggiBadan': tinggiBadan,
      'beratBadan': beratBadan,
      'riwayat': riwayat
    };
  }
}