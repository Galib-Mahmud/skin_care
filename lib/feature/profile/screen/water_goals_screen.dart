// lib/feature/goals/screen/water_goals_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_appbar.dart';
import '../controller/water_goal_controller.dart';

class WaterGoalsScreen extends StatelessWidget {
  const WaterGoalsScreen({super.key});

  static const List<String> _skinGoalsList = [
    'Hydration', 'Dry', 'Firm', 'Smooth',
    'Oily', 'Breakout', 'Bright', 'Soft',
  ];

  @override
  Widget build(BuildContext context) {
    // Using Get.put or Get.find depending on your navigation setup
    final controller = Get.put(WaterGoalController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Goals'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // ─── Water Goal Section ──────────────────────────────
              _GoalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Water Goals'),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Daily Target', style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                          '${controller.waterSliderValue.value.toInt()} oz / 32 oz',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                        activeTrackColor: Colors.black,
                        inactiveTrackColor: Colors.black12,
                      ),
                      child: Slider(
                        value: controller.waterSliderValue.value,
                        min: 0, max: 32, divisions: 32,
                        onChanged: (val) => controller.waterSliderValue.value = val,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // ─── Skin Goals Section ──────────────────────────────
              _GoalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Skin Goals'),
                    SizedBox(height: 12.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 2.8,
                      ),
                      itemCount: _skinGoalsList.length,
                      itemBuilder: (_, i) => _SelectPill(
                        label: _skinGoalsList[i],
                        currentGoal: controller.skinGoal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // ─── Prayer Goals Section ────────────────────────────
              _GoalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Prayer Goals'),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CounterButton(
                          icon: Icons.remove,
                          onTap: () => controller.prayerValue.value > 0 ? controller.prayerValue.value-- : null,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            '${controller.prayerValue.value} Times',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        _CounterButton(
                          icon: Icons.add,
                          onTap: () => controller.prayerValue.value++,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // ─── Save Button ─────────────────────────────────────
              controller.isSaving.value
                  ? const CircularProgressIndicator(color: Colors.black)
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: controller.saveAll,
                  child: Text('Save Goals', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Sub-widgets to keep build method clean
class _GoalCard extends StatelessWidget {
  final Widget child;
  const _GoalCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: Colors.black87));
  }
}

class _SelectPill extends StatelessWidget {
  final String label;
  final RxString currentGoal;
  const _SelectPill({required this.label, required this.currentGoal});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = currentGoal.value == label;
      return InkWell(
        onTap: () => currentGoal.value = label,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: isSelected ? Colors.black : Colors.black12),
          ),
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}