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
    bool isBase64 = imageSrc.startsWith('data:image');
    Uint8List bytes = imageSrc == 'No Images'
        ? Uint8List(0) // Fallback for 'No Images'
        : imageSrc.startsWith('data:image')
            ? base64Decode(imageSrc.split(',').last) // Decode base64 image
            : Uint8List(0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],// Warna abu-abu terang
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 50, // Max width for image
          height: 50, // Max height for image
          child: isBase64
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                  ),
                )
              : (imageSrc.startsWith('http') // If it's a URL, use Image.network
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageSrc,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image, size: 50)), // Default icon if no image
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

