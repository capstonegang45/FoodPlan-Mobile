import 'package:flutter/material.dart';

class FullResep extends StatefulWidget {
  const FullResep({super.key});

  @override
  State<FullResep> createState() => _FullResepState();
}

class _FullResepState extends State<FullResep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
          'FOODPLAN APP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          key: const Key('IconBack'),
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/beranda');
          },
        ),
      ),
    );
  }
}