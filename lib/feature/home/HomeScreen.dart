import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with welcome message and Bible verse
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8632C), // Adjusted color to match the image tones
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back :',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Glowing skin is always in take care of it, and it will take care of you!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Bible Verse\n"Glowing skin is always in take care of it, and it will take care of you"',
                      style: TextStyle(
                        color: Color(0xFFE8632C),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // Water Goal and Mood Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard(
                    icon: Icons.water_drop,
                    title: 'Water Goal',
                    value: '38%',
                    subtitle: '24 / 64 oz',
                    progress: 0.38,
                    color: Colors.blue,
                  ),
                  _buildCard(
                    icon: Icons.favorite,
                    title: 'Mood',
                    value: 'Blessed',
                    subtitle: 'Today',
                    progress: 0.0,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Featured for You Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured for You',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RouteName.checkinScreen1);
                    },
                    child: const Text(
                      'View All >',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Product Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    _buildProductCard('assets/images/home/Item1.png'),
                    _buildProductCard('assets/images/home/Item2.png'),
                    _buildProductCard('assets/images/home/Item3.png'),
                    _buildProductCard('assets/images/home/Item4.png'),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', true),
                  _buildNavItem(Icons.search, 'Search', false),
                  _buildNavItem(Icons.add, 'Add', false),
                  _buildNavItem(Icons.favorite, 'Favorite', false),
                  _buildNavItem(Icons.person, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required double progress,
    required Color color,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold),
          ),
          if (title == 'Water Goal') ...[
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ] else ...[
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
      ),
    );
  }

  Widget _buildProductCard(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF020953) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF020953) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
