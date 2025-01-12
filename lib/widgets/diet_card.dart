import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
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
    Uint8List? bytes;

    // Tentukan apakah image_src adalah Base64 atau URL
    if (image_src.startsWith('data:image')) {
      try {
        bytes = base64Decode(image_src.split(',').last);
      } catch (e) {
        // Jika decoding gagal, set bytes ke null
        bytes = null;
      }
    }

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
              child: bytes != null
                  ? Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      height: 172.7,
                      width: double.infinity,
                    )
                  : image_src.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: image_src,
                          fit: BoxFit.cover,
                          height: 172.7,
                          width: double.infinity,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const Icon(Icons.image, size: 50), // Default icon jika gambar tidak ada
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
