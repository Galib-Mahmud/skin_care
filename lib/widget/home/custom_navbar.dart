// Custom Bottom Navigation Bar Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';

import '../../feature/home/checkin_screen1.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(154, 154, 154, 1),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home,
              isSelected: selectedIndex == 0,
              onTap: () => onItemSelected(0),
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.layers,
              isSelected: selectedIndex == 1,
              onTap: () => onItemSelected(1),
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.shopping_bag_outlined,
              isSelected: selectedIndex == 2,
              onTap: () => onItemSelected(2),
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.settings,
              isSelected: selectedIndex == 3,
              onTap: () => onItemSelected(3),
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.person_outline,
              isSelected: selectedIndex == 4,
              onTap: () => onItemSelected(4),
              label: 'Home',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;

  const _NavItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(47, 46, 46, 1) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:isSelected ? Colors.white:Colors.black,
              size: 24,
            ),
            if (isSelected && label != null) ...[
              SizedBox(width: 10),
              Text(
                label!,
                style:  TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}