import 'package:flutter/material.dart';

class Overview1 extends StatelessWidget {
  const Overview1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Plate Image
            Image.asset(
              'assets/img/food_plate.png',
              height: 200,
            ),
            const SizedBox(height: 32),

            // Title
            const Text(
              'Welcome to\nFOODPLAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Saatnya menjaga kesehatan dengan pola makan yang seimbang. Mulailah perjalanan diet sehatmu sekarang!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(isActive: true),
                _buildPageIndicator(isActive: false),
                _buildPageIndicator(isActive: false),
              ],
            ),
            const SizedBox(height: 100),

            // Skip and Next Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loginorregister');
                  },
                  child: const Text(
                    'LEWATI',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/overview2');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                  ),
                  child: const Text(
                    'LANJUT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color.fromARGB(255, 68, 91, 75) : Colors.grey[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

class Overview2 extends StatelessWidget {
  const Overview2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Plate Image
            Image.asset(
              'assets/img/food_plate.png',
              height: 200,
            ),
            const SizedBox(height: 32),

            // Title
            const Text(
              'Butuh inspirasi diet sehat?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Dapatkan rekomendasi masakan dan rencana diet dari bahan yang kamu punya. Mulai langkah baru hari ini!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(isActive: false),
                _buildPageIndicator(isActive: true),
                _buildPageIndicator(isActive: false),
              ],
            ),
            const SizedBox(height: 100),

            // Skip and Next Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loginorregister');
                  },
                  child: const Text(
                    'LEWATI',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/overview3');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                  ),
                  child: const Text(
                    'LANJUT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color.fromARGB(255, 68, 91, 75) : Colors.grey[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}

class Overview3 extends StatelessWidget {
  const Overview3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Plate Image
            Image.asset(
              'assets/img/food_plate.png',
              height: 200,
            ),
            const SizedBox(height: 32),

            // Title
            const Text(
              'Ayo mulai perjalanan diet sehatmu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 91, 75),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Bersama FOODPLAN, mencapai kesehatan lebih mudah dan menyenangkan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPageIndicator(isActive: false),
                _buildPageIndicator(isActive: false),
                _buildPageIndicator(isActive: true),
              ],
            ),
            const SizedBox(height: 100),

            // Skip and Start Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loginorregister');
                  },
                  child: const Text(
                    'LEWATI',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loginorregister');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 68, 91, 75),
                  ),
                  child: const Text(
                    'MULAI',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color.fromARGB(255, 68, 91, 75): Colors.grey[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
