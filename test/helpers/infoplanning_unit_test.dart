import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/detail_planning.dart';

void main() {
  group('InformasiRencana', () {
    test('should create a widget with the correct information', () {
      final informasi = [
        'Deskripsi Test',
        'Mudah',
        '30 Menit',
        '3 Hari',
        'Jika Anda ingin menurunkan berat badan',
        'Lakukan olahraga setiap hari',
      ];

      final widget = InformasiRencana(informasi: informasi);
      expect(widget.informasi.length, 6);
      expect(widget.informasi[0], 'Deskripsi Test');
    });
  });

  group('RekomendasiMakanan', () {
    test('should create a widget with the correct recommendations', () {
      final rekomendasiMakanan = {
        'Pagi': [
          {'title': 'Oatmeal', 'description': 'Sarapan sehat dengan oatmeal'},
        ],
      };

      final widget = RekomendasiMakanan(rekomendasiMakanan: rekomendasiMakanan);
      expect(widget.rekomendasiMakanan['Pagi']!.length, 1);
      expect(widget.rekomendasiMakanan['Pagi']![0]['title'], 'Oatmeal');
    });
  });

  group('Aktivitas', () {
    test('should create a widget with the correct activity', () {
      const aktivitas = 'Olahraga setiap hari selama 30 menit';
      // ignore: prefer_const_constructors
      final widget = Aktivitas(aktivitas: aktivitas);
      expect(widget.aktivitas, aktivitas);
    });
  });
}
