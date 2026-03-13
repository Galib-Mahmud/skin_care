// lib/feature/goals/screen/water_goals_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widget/auth/custom_appbar.dart';
import '../controller/water_goal_controller.dart';

class WaterGoalsScreen extends StatelessWidget {
  const WaterGoalsScreen({super.key});

  static const List<String> _skinGoals = [
    'Hydration', 'Dry',      'Firm',   'Smooth',
    'Oily',      'Breakout', 'Bright', 'Soft',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WaterGoalController());

    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Goals'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ─── Loading indicator ─────────────────────────────────
            Obx(() => controller.isLoading.value
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                  child: CircularProgressIndicator(color: Colors.black)),
            )
                : const SizedBox.shrink()),

            // ─── Water Goal slider ─────────────────────────────────
            _GoalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Water Goals'),
                  SizedBox(height: 30.h),
                  Obx(() => Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${controller.sliderValue.value.toInt()} oz/32 oz',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10.w),
                      SizedBox(
                        width: double.infinity,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10,
                            activeTrackColor: Colors.black87,
                            inactiveTrackColor: const Color(0x22000000),
                            thumbColor: Colors.black,
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 10),
                            tickMarkShape: SliderTickMarkShape.noTickMark,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                          ),
                          child: Slider(
                            value: controller.sliderValue.value,
                            min: 0,
                            max: 32,
                            divisions: 4,
                            onChanged: (v) =>
                            controller.sliderValue.value = v,
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // ─── Skin Goals ────────────────────────────────────────
            _GoalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Skin Goals'),
                  SizedBox(height: 10.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.9,
                    ),
                    itemCount: _skinGoals.length,
                    itemBuilder: (_, i) {
                      final label = _skinGoals[i];
                      return _SelectPill(
                        label: label,
                        skinGoal: controller.skinGoal,
                        onTap: () => controller.skinGoal.value = label,
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // ─── Prayer counter ────────────────────────────────────
            _GoalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('PRAYER Goals'),
                  SizedBox(height: 10.h),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CircleIconButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (controller.prayerValue.value > 0) {
                            controller.prayerValue.value--;
                          }
                        },
                      ),
                      const SizedBox(width: 14),
                      _CounterPill(
                          text: '${controller.prayerValue.value} Time'),
                      const SizedBox(width: 14),
                      _CircleIconButton(
                        icon: Icons.add,
                        onTap: () => controller.prayerValue.value++,
                      ),
                    ],
                  )),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ─── Save button ───────────────────────────────────────
            Obx(() => Center(
              child: controller.isSaving.value
                  ? const CircularProgressIndicator(color: Colors.black)
                  : _SaveButton(
                label: 'Save',
                onTap: controller.saveAll,
              ),
            )),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

/* ═══════════════════════════ UI Widgets ══════════════════════════════════ */

class _GoalCard extends StatelessWidget {
  final Widget child;
  const _GoalCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        boxShadow: const [
          BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 3)),
        ],
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
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87),
    );
  }
}

// ─── Obx is INSIDE this widget, not outside in GridView ───────────────────
class _SelectPill extends StatelessWidget {
  final String label;
  final RxString skinGoal;
  final VoidCallback onTap;

  const _SelectPill({
    required this.label,
    required this.skinGoal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = skinGoal.value == label;
      return Material(
        color: selected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: selected ? 3 : 2,
        shadowColor: const Color(0x22000000),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: selected
                  ? null
                  : Border.all(
                  color: const Color(0xFFEAEAEA), width: 1.2),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _CounterPill extends StatelessWidget {
  final String text;
  const _CounterPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border:
          Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
            Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
          ),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SaveButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      shadowColor: const Color(0x33000000),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          child: const Text(
            'Save',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}