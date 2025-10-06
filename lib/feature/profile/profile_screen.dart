import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen1 extends StatelessWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.edit, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Jocelyn Nicole',
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Member since June 2023',
                      style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.h),

            // Goals Section
            Text('Your Goals', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),
            _GoalRow(goalTitle: 'Daily Water Goal', goalValue: '64 oz'),
            _GoalRow(goalTitle: 'Skin Focus', goalValue: 'Hydration'),
            _GoalRow(goalTitle: 'Daily Prayer', goalValue: '3 times'),
            SizedBox(height: 25.h),

            // Buttons and Status Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatusBox(label: '6/7', statusText: 'Days water goal met'),
                _StatusBox(label: '7/7', statusText: 'Days checked in'),
              ],
            ),
            SizedBox(height: 25.h),

            // Action Buttons
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit Goals'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
            SizedBox(height: 20.h),

            // Settings Section
            Text('Settings', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            _SettingItem(title: 'Notifications'),
            _SettingItem(title: 'Privacy'),
            _SettingItem(title: 'About'),
            _SettingItem(title: 'Shop History'),
            _SettingItem(title: 'Change Password'),
            _SettingItem(title: 'Logout'),
          ],
        ),
      ),
    );
  }
}

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
        Text(goalValue, style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
      ],
    );
  }
}

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
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.black26),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Text(statusText, style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;

  const _SettingItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {},
    );
  }
}
