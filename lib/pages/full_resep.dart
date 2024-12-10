import 'package:flutter/material.dart';
import 'package:food_plan/widgets/custom_btn.dart';

class FullResep extends StatefulWidget {
  const FullResep({super.key});

  @override
  State<FullResep> createState() => _FullResepState();
}

class _FullResepState extends State<FullResep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Apply dark theme only to this page
      body: Theme(
        data: ThemeData.dark(),  // Dark theme for this page
        child: Column(
          children: [
            Expanded(
              // This will push the rest of the content to the center
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                    children: [
                      CustomButton(
                        label: "Resep Diet Normal",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: "Resep Diet Normal",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: "Resep Diet Normal",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: "Resep Diet Normal",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        label: "Resep Diet Normal",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 68, 91, 75),
              ),
              child: IconButton(
                icon: const Icon(Icons.home, size: 30, color: Colors.white), // Icon home
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/beranda');
                },
              ),
            ),
            const SizedBox(height: 10), // Optional: space between the icon and bottom
          ],
        ),
      ),
    );
  }
}
