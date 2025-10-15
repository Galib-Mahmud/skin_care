import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/route_name.dart';
import '../../widget/auth/custom_button.dart';

class Question3 extends StatefulWidget {
  const Question3({super.key});

  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  // Variable to store the selected option
  String selectedOption = "Tired 😴"; // Default selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217, 1), // background color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                "How are you feeling today?",
                style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: 'Gayathri',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "What are the top issues you’d like to improve?",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Gayathri',
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 40.h),
            _buildOptionButton("Happy 😀"),
            SizedBox(height: 15.h),
            _buildOptionButton("Stressed 😓"),
            SizedBox(height: 15.h),
            _buildOptionButton("Tired 😴"),
            SizedBox(height: 15.h),
            _buildOptionButton("Excited 🤩"),
            SizedBox(height: 15.h),
            _buildOptionButton("Calm 🙂"),
            SizedBox(height: 60.h),
            CustomButton(text: 'Continue', onPressed: () {
              Get.toNamed(RouteName.question4);
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
            style: TextStyle(color: Colors.black, fontSize: 16.sp, fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
