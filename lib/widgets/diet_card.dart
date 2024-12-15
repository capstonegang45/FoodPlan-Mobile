import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class DietCard extends StatelessWidget {
  final String title;
  // ignore: non_constant_identifier_names
  final String image_src;
  final VoidCallback onTap;

  const DietCard({
    super.key,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.image_src,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Decode base64 image if valid
    Uint8List bytes = image_src == 'No Images'
        ? Uint8List(0) // If no image, provide empty byte array
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: bytes.isEmpty
                  ? const Icon(Icons.image, size: 50) // Default icon
                  : Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      height: 172.7,
                      width: double.infinity,
                    ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjusted padding
              decoration: BoxDecoration(
                color: Colors.teal[900], // Dark green color
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0), // Added horizontal padding
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Ellipsis for long title
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Increased font size for better readability
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
