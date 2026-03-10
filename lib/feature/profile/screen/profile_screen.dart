// lib/feature/profile/screen/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import '../controller/profile_controller.dart';

class ProfileScreen1 extends StatelessWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Profile Card ──────────────────────────────────
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      children: [
                        SizedBox(width: 12.w),
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                          controller.profileImage.value.isNotEmpty
                              ? NetworkImage(controller.profileImage.value)
                              : const AssetImage(
                              'assets/images/home/bot.png')
                          as ImageProvider,
                        ),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.only(top: 27.h, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.fullName.value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.email.value,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: () => Get.toNamed(RouteName.editProfile),
                            child: ImageIcon(
                              const AssetImage("assets/images/shop/edit.png"),
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

                // ─── Goals Card ────────────────────────────────────
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: const Color.fromRGBO(255, 255, 255, 0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Goals',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 15.h),
                        _GoalRow(
                          goalTitle: 'Daily Water Goal',
                          goalValue: '${controller.waterGoal.value} glasses',
                        ),
                        SizedBox(height: 10.h),
                        Container(height: 1, color: Colors.grey.withOpacity(0.25)),
                        SizedBox(height: 10.h),
                        _GoalRow(
                          goalTitle: 'Skin Focus',
                          goalValue: controller.skinGoal.value,
                        ),
                        SizedBox(height: 10.h),
                        Container(height: 1, color: Colors.grey.withOpacity(0.25)),
                        SizedBox(height: 10.h),
                        _GoalRow(
                          goalTitle: 'Daily Prayer',
                          goalValue: '${controller.remainder.value} times',
                        ),
                        SizedBox(height: 10.h),
                        Container(height: 1, color: Colors.grey.withOpacity(0.25)),
                        SizedBox(height: 40.h),
                        ElevatedButton(
                          onPressed: () => Get.toNamed(RouteName.watergoal),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(47, 46, 46, 1),
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          child: Text('Edit Goals',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        SizedBox(height: 20.h),
                        Text('This Week',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _StatusBox(
                                label: '6/7',
                                statusText: 'Days water goal met'),
                            _StatusBox(
                                label: '7/7',
                                statusText: 'Days checked in'),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ─── Settings Card ─────────────────────────────────
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: const Color.fromRGBO(255, 255, 255, 0.4),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.h, bottom: 16.h, left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SettingItem(
                          icon: Image.asset(
                              "assets/images/splash/notification.png"),
                          title: 'Notifications',
                          onTap: () => Get.toNamed(RouteName.notification),
                        ),
                        _Divider(),
                        _SettingItem(
                          icon: Image.asset("assets/images/splash/about.png"),
                          title: 'About',
                          onTap: () => Get.toNamed(RouteName.contact),
                        ),
                        _Divider(),
                        _SettingItem(
                          icon: Image.asset(
                              "assets/images/splash/history.png"),
                          title: 'Shop History',
                          onTap: () => Get.toNamed(RouteName.shophistory),
                        ),
                        _Divider(),
                        _SettingItem(
                          icon: Image.asset(
                              "assets/images/splash/privacy.png"),
                          title: 'Privacy',
                          onTap: () => Get.toNamed(RouteName.privacy),
                        ),
                        _Divider(),
                        _SettingItem(
                          icon: Image.asset(
                              "assets/images/splash/change password.png"),
                          title: 'Change Password',
                          onTap: () => Get.toNamed(RouteName.resetPass),
                        ),
                        _Divider(),
                        _SettingItem(
                          icon: Image.asset(
                              "assets/images/splash/change password.png"),
                          title: 'Logout',
                          onTap: () => controller.logout(),
                        ),
                        _Divider(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: Container(height: 1, color: Colors.grey.withOpacity(0.25)),
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
        const Spacer(),
        Text(goalValue,
            style: TextStyle(fontSize: 16.sp, color: Colors.black)),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(47, 46, 46, 1),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 5.h),
          Text(statusText,
              style: TextStyle(fontSize: 12.sp, color: Colors.white)),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final dynamic icon;
  final void Function()? onTap;
  const _SettingItem(
      {required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon,
      title: Text(title,
          style:
          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
      ),
      onTap: onTap,
    );
  }
}