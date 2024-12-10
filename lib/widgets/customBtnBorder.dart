import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonBorder extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double? height;
  final IconData? icon;

  const CustomButtonBorder({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = const Color.fromARGB(255, 34, 85, 44), // Default border color (hijau tua)
    this.height = 40.0, // Default height
    this.icon, // Ikon opsional
  });

  @override
  Widget build(BuildContext context) {
    // Mengambil lebar layar menggunakan MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Padding untuk margin kiri-kanan
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor!, width: 2), // Border hijau tua
          backgroundColor: Colors.transparent, // Warna tengah transparan
          minimumSize: Size(screenWidth, height!), // Lebar sesuai layar, tinggi dapat diatur
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Border radius opsional
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              FaIcon(
                icon,
                color: borderColor, // Warna ikon sama dengan border
              ),
            if (icon != null) const SizedBox(width: 8), // Spasi antara ikon dan teks
            Text(
              label,
              style: TextStyle(
                color: borderColor, // Warna teks sama dengan warna border
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
