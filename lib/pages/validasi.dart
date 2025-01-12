// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_plan/helpers/validasi_helper.dart';
import 'package:food_plan/provider/rencana_providers.dart';
import 'package:food_plan/widgets/customBtnBorder.dart';
import 'package:food_plan/widgets/toastification_wigdet.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ValidasiScreen extends StatefulWidget {
  const ValidasiScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ValidasiScreenState createState() => _ValidasiScreenState();
}

class _ValidasiScreenState extends State<ValidasiScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variabel untuk menyimpan input pengguna
  String? _jenisKelamin, _riwayat;
  int? _categoryId, _usia, _tinggiBadan, _beratBadan;

  // Fungsi untuk mengirim data validasi
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Validasi form
      try {
        // Mengirim data ke server
        var response = await ValidasiHelper().submitValidationData(
          usia: _usia ?? 0,
          jenisKelamin: _jenisKelamin ?? '',
          tinggiBadan: _tinggiBadan ?? 0,
          beratBadan: _beratBadan ?? 0,
          riwayat: _riwayat ?? '',
          categoryId: _categoryId ?? 1,
        );

        if (response['status'] == 'success') {
          Future.microtask(() {
            final provider =
                Provider.of<RencanaProvider>(context, listen: false);
            if (provider.plans.isEmpty) {
              provider.loadPlans(); // Hanya panggil jika data belum ada
            }
          });
          // Navigasi ke halaman berikutnya jika berhasil
          await showCustomToastNotification(
              context: context,
              title: 'Success',
              message: response['message'],
              type: ToastificationType.success);
          Navigator.pushNamed(context, '/beranda');
        } else {
          await showCustomToastNotification(
              context: context,
              title: 'Error',
              message: response['message'],
              type: ToastificationType.error);
        }
      } catch (e) {
        await showCustomToastNotification(
            context: context,
            title: 'Error',
            message: 'Gagal mengirim data',
            type: ToastificationType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi tambahan'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/validation.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Mari mulai dengan menentukan target.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  key: const Key('JenisDietDropdown'),
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Diet',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  value: _categoryId,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Diet Normal')),
                    DropdownMenuItem(value: 2, child: Text('Diet Berat Badan')),
                    DropdownMenuItem(value: 3, child: Text('Diet Olahraga')),
                    DropdownMenuItem(value: 4, child: Text('Diet Sakit')),
                    DropdownMenuItem(
                        value: 5, child: Text('Diet Hamil dan Menyusui')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _categoryId = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Kategori diet tidak boleh kosong' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  key: const Key('JenisKelaminDropdown'),
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Kelamin',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  value: _jenisKelamin,
                  items: const [
                    DropdownMenuItem(
                        value: 'Laki-Laki', child: Text('Laki-Laki')),
                    DropdownMenuItem(
                        value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Jenis kelamin tidak boleh kosong' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usia',
                    suffixText: 'tahun',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _usia = int.tryParse(value),
                  validator: (value) =>
                      value!.isEmpty || int.tryParse(value) == null
                          ? 'Usia harus berupa angka'
                          : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    labelText: 'Masukkan Tinggi Badan',
                    suffixText: 'Cm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _tinggiBadan = int.tryParse(value),
                  validator: (value) =>
                      value!.isEmpty || int.tryParse(value) == null
                          ? 'Tinggi badan harus berupa angka'
                          : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    labelText: 'Masukkan Berat Badan',
                    suffixText: 'Kg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _beratBadan = int.tryParse(value),
                  validator: (value) =>
                      value!.isEmpty || int.tryParse(value) == null
                          ? 'Berat badan harus berupa angka'
                          : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    labelText: 'Masukkan Riwayat Medis',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) => _riwayat = value,
                  validator: (value) => value!.isEmpty
                      ? 'Riwayat medis tidak boleh kosong'
                      : null,
                ),
                // Next Button
                const SizedBox(height: 20),
                CustomButtonBorder(
                  label: 'Lanjut',
                  height: 45,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
