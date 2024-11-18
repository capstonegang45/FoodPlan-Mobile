import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class DietCard extends StatelessWidget {
  final String title;
  final String description;
  // ignore: non_constant_identifier_names
  final String image_src;
  final VoidCallback onTap;

  const DietCard({
    super.key,
    required this.title,
    required this.description,
    // ignore: non_constant_identifier_names
    required this.image_src,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Only attempt to decode if the image_src is a valid base64 string
    Uint8List bytes = image_src == 'No Images'
        ? Uint8List(0) // If no image, provide an empty byte array
        : base64Decode(image_src.split(',').last);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: bytes.isEmpty
                  ? const Icon(Icons.image,
                      size: 50) // Show default icon if no image
                  : Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      height: 140,
                      width: double.infinity,
                    ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6.5),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 92, 117, 87), // Dark green color
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
