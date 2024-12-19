import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class DietCardSmall extends StatelessWidget {
  final String title;
  // ignore: non_constant_identifier_names
  final String image_src;
  final VoidCallback onTap;

  const DietCardSmall({
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
      child: SizedBox(
        width: 200, // Set fixed width for the card
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: bytes.isEmpty
                    ? const Icon(Icons.image, size: 30) // Smaller default icon
                    : Image.memory(
                        bytes,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0), // Adjusted padding
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 70, 34), // Dark green color
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0), // Added horizontal padding
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Ellipsis for long title
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Reduced font size for title
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
