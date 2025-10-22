import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';
import '../../widget/auth/custom_button.dart';

class Question4 extends StatefulWidget {
  const Question4({super.key});

  @override
  _Question4State createState() => _Question4State();
}

class _Question4State extends State<Question4> {
  // Variable to store the selected option
  String selectedOption = "3 time"; // Default selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1), // background color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                textAlign: TextAlign.center,
                "How many prayers would you like reminders for?",
                style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "What are the top issues you’d like to improve?",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30.h),
            _buildOptionButton("1 time"),
            SizedBox(height: 10.h),
            _buildOptionButton("2 time"),
            SizedBox(height: 10.h),
            _buildOptionButton("3 time"),
            SizedBox(height: 10.h),
            _buildOptionButton("4 time"),
            SizedBox(height: 60.h),
            CustomButton(text: 'Continue', onPressed: () {
              Get.toNamed(RouteName.question5);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label) {
    // Check if the current label is the selected one
    bool isSelected = selectedOption == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label; // Update selected option
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        height: 60.h,
        width: 353.w,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow color
            blurRadius: 5, // Spread of the shadow
            offset: Offset(0, 4), // Position of the shadow (downwards)
          ),
        ],
          color: isSelected ? Color.fromRGBO(0, 0, 0, 0.4) : Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: isSelected? Colors.white: Colors.black, fontSize: 16.sp, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
