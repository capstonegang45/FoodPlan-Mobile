import 'package:flutter/material.dart';
// import 'package:food_plan/pages/home_page.dart';

class ValidasiScreen extends StatefulWidget {
  const ValidasiScreen({super.key});

  @override
  ValidasiFormScreenState createState() => ValidasiFormScreenState();
}

class ValidasiFormScreenState extends State<ValidasiScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _dietType;
  String? _gender;
  String? _height;
  String? _weight;
  String? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi tambahan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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

                // Diet Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Diet',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  value: _dietType,
                  items: [
                    'Diet Normal',
                    'Diet Berat Badan',
                    'Diet Olahraga',
                    'Diet Sakit',
                    'Diet Hamil dan Menyusui'
                  ].map((diet) {
                    return DropdownMenuItem(
                      value: diet,
                      child: Text(diet),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dietType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Pilih jenis diet' : null,
                ),
                const SizedBox(height: 10),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Kelamin',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  value: _gender,
                  items: [
                    'Laki-laki',
                    'Perempuan',
                  ].map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Pilih jenis kelamin' : null,
                ),
                const SizedBox(height: 10),

                // Age Field
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Usia',
                    suffixText: 'tahun',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    _age = value;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Masukkan usia Anda' : null,
                ),
                const SizedBox(height: 10),

                // Height Field
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    labelText: 'Masukkan Tinggi Badan',
                    suffixText: 'Cm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    _height = value;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Masukkan tinggi badan Anda' : null,
                ),
                const SizedBox(height: 10),

                // Weight Field
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 68, 91, 75), fontSize: 12),
                    labelText: 'Masukkan Berat Badan',
                    suffixText: 'Kg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 68, 91, 75)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (value) {
                    _weight = value;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Masukkan berat badan Anda' : null,
                ),
                const SizedBox(height: 20),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/beranda');
                      if (_formKey.currentState!.validate()) {
                        // Navigate to the next screen or perform submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
