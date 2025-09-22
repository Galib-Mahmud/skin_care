import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen2 extends StatelessWidget {
  const CheckinScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4EA), // Beige background matching the design
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resources',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grow in faith and wellness',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Resource Cards Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildResourceCard(
                      onTap: () {
                        Get.toNamed(RouteName.profileScreen);
                      },
                      icon: Icons.article,
                      title: 'Skin Care Articles',
                      subtitle: 'Read and learn locally TSM',
                    ),
                    _buildResourceCard(

                      icon: Icons.favorite,
                      title: 'Daily Devotions',
                      subtitle: 'Stay in faith movement!',
                    ),
                    _buildResourceCard(
                      icon: Icons.article,
                      title: 'Skin Care Articles',
                      subtitle: 'Read and learn TSM',
                    ),
                    _buildResourceCard(
                      icon: Icons.favorite,
                      title: 'Daily Devotions',
                      subtitle: 'Stay in faith movement!',
                    ),
                    _buildResourceCard(
                      icon: Icons.add,
                      title: 'AI Recipe Generator',
                      subtitle: 'Healing means for glow',
                    ),
                    _buildResourceCard(
                      icon: Icons.edit,
                      title: 'Journal Prompts',
                      subtitle: 'A guided reflection',
                    ),
                    _buildResourceCard(
                      icon: Icons.book,
                      title: '9Min Intro',
                      subtitle: 'Presence and awareness',
                    ),
                    _buildResourceCard(
                      icon: Icons.favorite,
                      title: 'Daily Devotions',
                      subtitle: 'Daily devotional',
                      onTap: () {
                        Get.toNamed(RouteName.profileScreen);
                      },
                    ),
                    _buildResourceCard(
                      icon: Icons.book,
                      title: 'Finding Rest in His Presence',
                      subtitle: 'Devotional on finding peace',
                    ),
                    _buildResourceCard(
                      icon: Icons.favorite,
                      title: 'Devotional',
                      subtitle: 'Overcome anxiety',
                    ),
                    _buildResourceCard(
                      icon: Icons.music_note,
                      title: 'Worship',
                      subtitle: 'Heal soul and wellness',
                    ),
                    _buildResourceCard(
                      icon: Icons.favorite,
                      title: 'Daily Devotional',
                      subtitle: 'H. Journaled on Israel',
                    ),
                  ],
                ),
              ),
            ),
            // Recommended Readings
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended Readings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildReadingCard(
                    title: 'Managing Dry Skin in Winter',
                    content: 'Learn how to care for your skin during harsh winter conditions.',
                  ),
                  SizedBox(height: 12),
                  _buildReadingCard(
                    title: 'Finding Rest in His Presence',
                    content: 'Devotional on finding peace and faith through prayer.',
                  ),
                  SizedBox(height: 12),
                  _buildReadingCard(
                    title: 'Finding Rest in His Presence',
                    content: 'Devotional on finding peace and faith through prayer.',
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Container(
              height: 60,
              color: Color(0xFFF7F4EA),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.black),
                  Icon(Icons.add, color: Colors.black),
                  Icon(Icons.favorite, color: Colors.black),
                  Icon(Icons.person, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCard({

    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: _getIconColor(icon)),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingCard({
    required String title,
    required String content,
  }) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Color _getIconColor(IconData icon) {

    if (icon == Icons.favorite) return Colors.red;
    if (icon == Icons.add) return Colors.blue;
    if (icon == Icons.edit) return Colors.blue;
    return Colors.green;
  }
}