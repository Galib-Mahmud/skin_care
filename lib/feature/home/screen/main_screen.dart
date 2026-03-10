import 'package:flutter/material.dart';
import 'package:skincare/feature/home/screen/home_screen.dart';
import 'package:skincare/feature/profile/screen/profile_screen.dart';
import 'package:skincare/feature/resources/screens/resources.dart';
import 'package:skincare/feature/shop/community_screen.dart';
import 'package:skincare/feature/shop/shop_screen1.dart';
import 'package:skincare/widget/home/custom_navbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  final List<Widget> _pages = const [
    HomeScreen(),
    CheckinScreen2(),
    ShopScreen1(),
    CommunityScreen(),
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
