import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class CheckinScreen1 extends StatefulWidget {
  @override
  _CheckinScreen1State createState() => _CheckinScreen1State();
}

class _CheckinScreen1State extends State<CheckinScreen1> {
  double waterIntake = 78.6;
  String mood = "Good";
  String skinStatus = "Clear";
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4EA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Text(
                  'Daily Check-in',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),


              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'How are you feeling today?',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),

              SizedBox(height: 12.h),

              // Mood
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  
                  children: [

                    _buildMoodButton('Struggling', '😞'),
                    _buildMoodButton('Okay', '😕'),
                    _buildMoodButton('Good', '😊'),
                    _buildMoodButton('Great', '😄'),
                    _buildMoodButton('Blessed', '🙏'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Skin Status
              Text('Skin Status', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSkinButton('Clear'),
                  _buildSkinButton('Dry'),
                  _buildSkinButton('Oily'),
                  _buildSkinButton('Breakout'),
                ],
              ),
              SizedBox(height: 20.h),

              // Water Intake
              Text('Water Intake', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: CircularProgressIndicator(
                        value: waterIntake / 100,
                        strokeWidth: 10.w,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF4A90E2)),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    Text('${waterIntake.toStringAsFixed(1)}%',
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      waterIntake += 8.0;
                      if (waterIntake > 100) waterIntake = 100;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 50.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text('Add 8 oz', style: TextStyle(fontSize: 16.sp)),
                ),
              ),
              SizedBox(height: 20.h),

              // Notes
              Text('Today\'s Notes', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'How is your skin feeling today? Any concerns or improvements?',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.checkinScreen2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 80.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text('Save Check In', style: TextStyle(fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF7F4EA),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
      ),
    );
  }

  Widget _buildMoodButton(String moodLabel, String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          mood = moodLabel;
        });
      },
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: mood == moodLabel ? Color(0xFF4A90E2) : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(emoji, style: TextStyle(fontSize: 20.sp))),
      ),
    );
  }

  Widget _buildSkinButton(String skinLabel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          skinStatus = skinLabel;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: skinStatus == skinLabel ? Color(0xFF4A90E2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          skinLabel,
          style: TextStyle(
            color: skinStatus == skinLabel ? Colors.white : Colors.black,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
