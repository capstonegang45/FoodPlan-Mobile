import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final String imageSrc;
  final String description;
  final VoidCallback onTap;

  const ProductListItem({
    super.key,
    required this.title,
    required this.imageSrc,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = imageSrc == 'No Images'
        ? Uint8List(0)
        : base64Decode(imageSrc.split(',').last);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],// Warna abu-abu terang
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 50, // Lebar maksimum untuk gambar
          height: 50, // Tinggi maksimum untuk gambar
          child: bytes.isEmpty
              ? const Icon(Icons.image, size: 50) // Default icon jika tidak ada gambar
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}

