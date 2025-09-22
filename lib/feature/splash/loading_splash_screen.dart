import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';



import '../../../routes/route_name.dart';

class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // animation time
    )..forward();

    // Navigate after animation completes
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteName.dailyFaith);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 150,
              height: 150,
              child: LiquidCircularProgressIndicator(
                value: _controller.value, // fill value (0.0 - 1.0)
                valueColor: const AlwaysStoppedAnimation(Colors.brown),
                backgroundColor: Colors.white,
                borderColor: Colors.brown.shade700,
                borderWidth: 2.0,
                direction: Axis.vertical,
                center: Text(
                  "${(_controller.value * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
