import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/home/check_in_screen2.dart';
import 'package:skincare/feature/home/checkin_screen1.dart';
import 'package:skincare/feature/home/home_screen.dart';
import 'package:skincare/feature/profile/profile_screen.dart';
import 'package:skincare/feature/shop/shop_screen1.dart';
import 'package:skincare/routes/route_name.dart';
import '../../widget/home/custom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  final List<Widget> _pages = const [
    HomeScreen(),
    CheckinScreen1(),
    CheckinScreen2(),
    ShopScreen1(),
    ProfileScreen1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

}
