import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Tambahkan ini
      backgroundColor: Colors.teal[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          key: Key('BerandaPage'),
          icon: Icon(Icons.home),
          label: 'BERANDA',
        ),
        BottomNavigationBarItem(
          key: Key('DeteksiPage'),
          icon: Icon(Icons.camera_alt_outlined),
          label: 'DETEKSI',
        ),
        BottomNavigationBarItem(
          key: Key('ChattbotPage'),
          icon: Icon(Icons.message_rounded),
          label: 'CHATBOT',
        ),
        BottomNavigationBarItem(
          key: Key('RencanaPage'),
          icon: Icon(Icons.calendar_today_outlined),
          label: 'RENCANA',
        ),
      ],
    );
  }
}
