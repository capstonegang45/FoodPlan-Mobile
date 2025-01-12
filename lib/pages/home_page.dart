// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_plan/helpers/auth_service.dart';
import 'package:food_plan/helpers/logout_helper.dart';
import 'package:food_plan/provider/users_providers.dart';
import 'package:food_plan/widgets/diet_card.dart';
import 'package:food_plan/widgets/produk_list.dart';
import 'package:food_plan/widgets/recipe_modal.dart';
import 'package:food_plan/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart'; // Import provider package

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadData();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/deteksi');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/chatbot');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/rencana');
          break;
      }
    }
  }

  Future<void> _handleDeleteAccount() async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Konfirmasi Hapus Akun'),
              content: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Text(
                      'Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan.'),
              actions: [
                if (!isLoading)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Batal'),
                  ),
                if (!isLoading)
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final result = await AuthService.deleteAccount();
                        await FirebaseAuth.instance.signOut();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(result['message'] ??
                                  'Akun berhasil dihapus')),
                        );

                        Navigator.pushReplacementNamed(context, '/login');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal menghapus akun: $e')),
                        );

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: const Text('Hapus'),
                  ),
              ],
            );
          },
        );
      },
    );

    if (confirmDelete != true) return;
  }

  Future<bool?> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  final List<String> bannerImages = [
    'assets/img/1.png',
    'assets/img/2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final user = userProvider.user;
            if (user == null) {
              return AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading...',
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900]),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
                pause: const Duration(
                    milliseconds: 300), // Pause between repetitions
              );
            }
            final avatarBytes = base64Decode(user.avatar!.split(',')[1]);
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: user.avatar!.startsWith('http')
                      ? NetworkImage(user.avatar!) // Jika URL
                      : MemoryImage(avatarBytes) // Jika base64
                          as ImageProvider,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nama,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              key: const Key('Pengaturan'),
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                // Menggunakan Scaffold.of(context) dengan Builder untuk membuka endDrawer
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        key: const Key('Drawer'),
        child: Column(
          children: [
            // Bagian header untuk informasi user
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                if (user == null) {
                  return const CircularProgressIndicator();
                }
                final avatarBytes = base64Decode(user.avatar!.split(',')[1]);

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal[900],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        key: const Key('DrawerAvatar'),
                        radius: 40,
                        backgroundImage: user.avatar!.startsWith('http')
                            ? NetworkImage(user.avatar!) // Jika URL
                            : MemoryImage(avatarBytes) // Jika base64
                                as ImageProvider,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Menu navigasi
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildModernMenuItem(
                    key: const Key('PengaturanAkun'),
                    icon: Icons.settings,
                    title: 'Pengaturan Akun',
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/profile'),
                  ),
                  _buildModernMenuDivider(),
                  _buildModernMenuItem(
                    key: const Key('Atur Notifikasi'),
                    icon: Icons.timeline,
                    title: 'Atur Notifikasi',
                    onTap: () => Navigator.pushReplacementNamed(
                        context, '/setting-notifikasi'),
                  ),
                  _buildModernMenuDivider(),
                  _buildModernMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () async {
                      // Tampilkan dialog konfirmasi sebelum logout
                      bool? shouldLogout =
                          await _showLogoutConfirmationDialog(context);
                      if (shouldLogout!) {
                        try {
                          // Panggil metode logout
                          await LogoutHelper().logout();
                          // Navigasi ke halaman login atau halaman lainnya setelah logout
                          Navigator.pushReplacementNamed(context, '/login');
                          // ignore: empty_catches
                        } catch (e) {}
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: _handleDeleteAccount,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white // Button color
                    ),
                child: const Text('Hapus Akun'),
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '© 2024 FoodPlan',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CarouselSlider(
                key: const Key('CarouselSlider'),
                options: CarouselOptions(
                  height: 100.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 1.0,
                  autoPlayInterval: const Duration(minutes: 10),
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final matchingProducts = userProvider.matchingProducts;
                final otherProducts = userProvider.otherProducts;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Carousel Slider and other widgets...
                      if (matchingProducts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'REKOMENDASI RESEP ${matchingProducts[0].categoryName.toUpperCase()}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: matchingProducts.length,
                        itemBuilder: (context, index) {
                          final product = matchingProducts[index];
                          return DietCard(
                            title: product.title,
                            image_src: product.image_src,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    RecipeDetailModal(product: product),
                              );
                            },
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'REKOMENDASI DIET LAINNYA',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: otherProducts.length > 10
                                ? 10
                                : otherProducts.length,
                            itemBuilder: (context, index) {
                              final product = otherProducts[index];
                              return ProductListItem(
                                title: product.title,
                                description: product.description,
                                imageSrc: product.image_src,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        RecipeDetailModal(product: product),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _buildModernMenuItem(
    {required IconData icon,
    required String title,
    VoidCallback? onTap,
    Key? key}) {
  return InkWell(
    key: key,
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    splashColor: Colors.teal[100],
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    ),
  );
}

// Fungsi untuk divider modern
Widget _buildModernMenuDivider() {
  return const Divider(
    color: Colors.grey,
    thickness: 1,
    height: 20,
    indent: 16,
    endIndent: 16,
  );
}
