class Kegiatan {
  final int id;
  final String planningId;
  final String aktivitas;

  // Constructor
  Kegiatan({
    required this.id,
    required this.planningId,
    required this.aktivitas,
  });

  // Factory method untuk membuat objek dari JSON
  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'],
      planningId: json['planningId'],
      aktivitas: json['aktivitas'],// Dapat null, jadi tidak perlu required
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planningId': planningId,
      'aktivitas': aktivitas,
    };
  }
}
