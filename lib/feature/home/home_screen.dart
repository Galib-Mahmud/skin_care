import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {


  double waterIntake = 78.6;
  String mood = "Good";
  String skinStatus = "Clear";
  final TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // Header with welcome message and Bible verse
              Container(

                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20.r),
                  image: const DecorationImage(
                    image:AssetImage(
                      'assets/images/home/Frame.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back .',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '"Glowing skin is always in take care of it, and it will take care of you"',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          height: 1.4,
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2.0,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bible Verse',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '"Glowing skin is always in take care of it, and it will take care of you"',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      children: [
                        Text(
                          'Daily Check-in',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gayathri',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Gayathri',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mood card
                  _SectionCard(
                    title: 'Your Mood',
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        Wrap(
                          alignment: WrapAlignment.spaceAround,

                          runSpacing: 12.h,
                          children: [
                            _moodItem('Struggling', '😞', 'Struggling'),
                            SizedBox(width: 12.h),
                            _moodItem('Okay', '😕', 'Okay'),
                            SizedBox(width: 12.h),
                            _moodItem('Good', '😊', 'Good'),
                            SizedBox(width: 12.h),
                            _moodItem('Great', '😄', 'Great'),
                            SizedBox(width: 12.h),
                            _moodItem('Blessed', '🙏', 'Blessed'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Skin Status card
                  _SectionCard(
                    title: 'Skin Status',
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 3.2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _skinChip('Clear'),
                          _skinChip('Dry'),
                          _skinChip('Oily'),
                          _skinChip('Breakout'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Water Intake card
                  _SectionCard(
                    title: 'Water Intake',
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 140.w,
                                height: 140.w,
                                child: CircularProgressIndicator(
                                  value: (waterIntake.clamp(0, 100)) / 100,
                                  strokeWidth: 10.w,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF333333),
                                  ),
                                  backgroundColor: Colors.black12,
                                ),
                              ),
                              Text(
                                '${waterIntake.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Row(
                              children: [
                                // Subtract button (left side)
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.r),
                                      bottomLeft: Radius.circular(24.r),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        waterIntake = (waterIntake - 8).clamp(0, 100);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.remove, color: Colors.white),
                                          SizedBox(width: 5.w),
                                          Text(
                                            '8 oz',
                                            style: TextStyle(color: Colors.white, fontSize: 17.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 1.w,
                                  height: 28.h,
                                  color: Colors.white24, // divider between + and -
                                ),

                                // Add button (right side)
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24.r),
                                      bottomRight: Radius.circular(24.r),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        waterIntake = (waterIntake + 8).clamp(0, 100);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, color: Colors.white),
                                          SizedBox(width: 5.w),
                                          Text(
                                            '8 oz',
                                            style: TextStyle(color: Colors.white, fontSize: 17.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Notes card
                  _SectionCard(
                    title: "Today's Notes",
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: notesController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                          'How is your skin feeling today? Any concerns or improvements?',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.sp,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(14.r),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),


                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(RouteName.checkinScreen2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Save Check In',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),






            ],
          ),
        ),

      ),
    );
  }

  // ——— Widgets ———

  Widget _moodItem(String label, String emoji, String keyLabel) {
    final isSelected = mood == keyLabel;
    return GestureDetector(
      onTap: () => setState(() => mood = keyLabel),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 55.w,
            height: 55.w,
            decoration: BoxDecoration(
              color: isSelected ? Color.fromRGBO(219, 234, 254,1) : Color.fromRGBO(255, 255, 255, 0.4),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: TextStyle(fontSize: 22.sp)),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 64.w,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                color: isSelected ? Colors.black : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skinChip(String label) {
    final selected = skinStatus == label;
    return InkWell(
      onTap: () => setState(() => skinStatus = label),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: selected ? Colors.black : const Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.black87);
  }
}

