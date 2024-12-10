class User {
  final int id;
  final String nama;
  final String email;
  final String username;
  final String password;
  final String? role;
  // ignore: non_constant_identifier_names
  final String? avatar; // Bisa null jika tidak ada gambar

  // Constructor
  User({
    required this.id,
    required this.nama,
    required this.email,
    required this.username,
    required this.password,
    this.role,
    // ignore: non_constant_identifier_names
    this.avatar,
  });

  // Factory method untuk membuat objek dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],// Dapat null, jadi tidak perlu required
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
    };
  }
}
