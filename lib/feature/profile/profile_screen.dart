import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class ProfileScreen1 extends StatelessWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(  // Remove Container with double.infinity height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                height: 100.h,
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(
                          'assets/images/home/bot.png',
                        ), // Ensure this image exists
                      ),
                      SizedBox(width: 10.w),
                      Padding(
                        padding: EdgeInsets.only(top: 27.h, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jocelyn Nicole',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Member since June 2023',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13.6.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(), // To align the edit icon to the right
                      InkWell(
                        onTap: () {}, // Handle edit action here
                        child: ImageIcon(
                          AssetImage("assets/images/shop/edit.png"),
                          size: 30,  // Size of the edit icon
                          color: Colors.black, // Color of the icon
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // Goals Section
              Card(
                elevation: 2,  // Optional: Add elevation for shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),  // Rounded corners
                ),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Padding(
                  padding: EdgeInsets.all(16.0),  // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title inside Card
                      Text(
                        'Your Goals',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Goal Rows
                      _GoalRow(goalTitle: 'Daily Water Goal', goalValue: '64 oz'),
                      _GoalRow(goalTitle: 'Skin Focus', goalValue: 'Hydration'),
                      _GoalRow(goalTitle: 'Daily Prayer', goalValue: '3 times'),
                      SizedBox(height: 25.h),

                      // Buttons and Status Section
                      Text(
                        'This Week',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StatusBox(label: '6/7', statusText: 'Days water goal met'),
                          _StatusBox(label: '7/7', statusText: 'Days checked in'),
                        ],
                      ),
                      SizedBox(height: 25.h),

                      // Edit Goals Button
                      ElevatedButton(
                        onPressed: () {}, // Handle the edit goals action
                        child: Text('Edit Goals', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(47, 46, 46, 1),
                          minimumSize: Size(double.infinity, 50.h),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Settings Section
              Card(
                elevation: 2,  // Optional: Add elevation for shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),  // Rounded corners
                ),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h,bottom: 16.h,left: 16.w),  // Padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title inside Card
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),  // Space between title and settings list

                      // Setting Items
                      _SettingItem(icon: Icons.notifications,title: 'Notifications',onTap: () {

                         Get.toNamed(RouteName.notification);
                      },),
                      _SettingItem(title: 'Privacy',icon: Icons.lock,onTap: () {
                        Get.toNamed(RouteName.privacy);
                      },),
                      _SettingItem(title: 'About',icon: Icons.info,onTap: () {
                        Get.toNamed(RouteName.contact);
                      },),
                      _SettingItem(title: 'Shop History',icon:Icons.history,onTap: () {
                        Get.toNamed(RouteName.shophistory);
                      },),
                      _SettingItem(title: 'Change Password',icon: Icons.lock,onTap: () {
                        Get.toNamed(RouteName.resetPass);
                      },),
                      _SettingItem(title: 'Logout',icon: Icons.logout),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Goal Row Widget
class _GoalRow extends StatelessWidget {
  final String goalTitle;
  final String goalValue;

  const _GoalRow({required this.goalTitle, required this.goalValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(goalTitle, style: TextStyle(fontSize: 16.sp)),
        Spacer(),
        Text(
          goalValue,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      ],
    );
  }
}

// Status Box Widget
class _StatusBox extends StatelessWidget {
  final String label;
  final String statusText;

  const _StatusBox({required this.label, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Color.fromRGBO(47, 46, 46, 1),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.black26),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              SizedBox(height: 5.h),
              Text(statusText, style: TextStyle(fontSize: 12.sp,color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;  // Specify the type of icon (IconData for Material Icons)
  final void Function()? onTap;  // Optional onTap callback function

  const _SettingItem({
    required this.title,
    required this.icon,
    this.onTap,  // Optional onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 24, color: Colors.black),  // Icon on the left
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),  // Title in the center
      trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),  // Right arrow icon
      onTap: onTap,  // Trigger the onTap callback if provided
    );
  }
}


