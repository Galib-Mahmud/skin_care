import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

import '../../widget/auth/custom_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedPlan = "Yearly";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 15.h),
            Text(
              "Start your 3-day FREE trial to continue.",
              style: TextStyle(
                fontSize: 24.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),

            // Timeline section
            Column(
              children: [
                buildTimelineRow(
                  icon: Icons.lock_outline,
                  title: "Today",
                  subtitle: "Get full access and see your mindset start to change.",
                ),
                buildTimelineRow(
                  icon: Icons.notifications_none,
                  title: "Day 2",
                  subtitle: "Get a reminder that your trial ends in 24 hours.",
                ),
                buildTimelineRow(
                  icon: Icons.workspace_premium_outlined,
                  title: "After day 3",
                  subtitle:
                  "Your free trial ends and you’ll be charged, cancel anytime before.",
                  isLast: true,
                ),
              ],
            ),

            SizedBox(height: 30.h),

            // Subscription cards
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedPlan = "Monthly"),
                    child: subscriptionCard(
                      title: "Monthly\n1.99 €/mo",

                      isSelected: selectedPlan == "Monthly",
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedPlan = "Yearly"),
                    child: subscriptionCard(
                      title: "Yearly\n0.99 €/mo",

                      isSelected: selectedPlan == "Yearly",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, color: Colors.green),
                SizedBox(width: 8.w),
                Text(
                  "No Payment Due Now",
                  style: TextStyle(fontSize: 14.sp, fontFamily: 'Poppins'),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            CustomButton(
              text: 'Start 3-day free trial',
              onPressed: () {
                Get.toNamed(RouteName.signup);
              },
            ),

            SizedBox(height: 10.h),
            Center(
              child: Text(
                "3 days free then 11.88€ a year",
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Timeline row widget
  Widget buildTimelineRow({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, size: 40.sp, color: Colors.black),
            if (!isLast)
              Container(
                width: 2.w,
                height: 60.h,
                color: Colors.grey,
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gayathri'),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'Gayathri',fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Subscription card widget
  Widget subscriptionCard({
    required String title,

    bool isSelected = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(

        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(

                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gayathri'),

          ),
          Column(

          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ],
      ),
    );
  }
}
