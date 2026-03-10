import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';
import 'package:skincare/widget/home/custom_navbar.dart';

class CheckinScreen1 extends StatefulWidget {
  const CheckinScreen1({super.key});

  @override
  State<CheckinScreen1> createState() => _CheckinScreen1State();
}

class _CheckinScreen1State extends State<CheckinScreen1> {
  double waterIntake = 78.6;
  String mood = "Good";
  String skinStatus = "Clear";
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
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
                        _moodItem('Okay', '😕', 'Okay'),
                        _moodItem('Good', '😊', 'Good'),
                        _moodItem('Great', '😄', 'Great'),
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
                          // small avatars (top-right)
                          Positioned(
                            right: -6.w,
                            top: 14.h,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 14.r,
                                  backgroundImage: const AssetImage(
                                    'assets/images/avatar1.png',
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                CircleAvatar(
                                  radius: 14.r,
                                  backgroundImage: const AssetImage(
                                    'assets/images/avatar2.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            waterIntake = (waterIntake + 8).clamp(0, 100);
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: Text(
                          'Add 8 oz +',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Notes card
              _SectionCard(
                title: "Today's Notes",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        fontSize: 13.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(14.r),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),


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
        ),
      ),

      // bottom bar (rounded container look)

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
              color: isSelected ? const Color(0xFF333333) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
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
          color: selected ? Colors.black : Colors.white,
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
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
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
