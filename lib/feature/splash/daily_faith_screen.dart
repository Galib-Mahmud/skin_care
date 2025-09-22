import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class DailyFaithScreen extends StatelessWidget {
  const DailyFaithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(2, 9, 83, 1),
              Color.fromRGBO(2, 9, 83, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            // Top image section with floating Next button
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/splash/Vector 3.png', // replace with your image path
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Next button on top-right

                ],
              ),
            ),
            // Text content
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Daily Faith Sales.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Smarter Listings, Faster Sales.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 30,
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Color(0xFFF5F5F5)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.skinCare);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: Color.fromRGBO(2, 9, 83, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        color: Color.fromRGBO(2, 9, 83, 1),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
