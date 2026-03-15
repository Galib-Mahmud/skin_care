// lib/feature/home/screen/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../profile/controller/weekly_goal_controller.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> _moods = [
    {'label': 'Struggling', 'emoji': '😞', 'key': 'Struggling 😞'},
    {'label': 'Okay',       'emoji': '😕', 'key': 'Okay 😕'},
    {'label': 'Good',       'emoji': '😊', 'key': 'Good 😊'},
    {'label': 'Great',      'emoji': '😄', 'key': 'Great 😄'},
    {'label': 'Blessed',    'emoji': '🙏', 'key': 'Blessed 🙏'},

  ];

  static const List<String> _skinOptions = [
    'Clear', 'Dry', 'Oily', 'Breakout'
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());
    final GoalTrackerController goalTrackerController =
    Get.put(GoalTrackerController());

    return Scaffold(
      body: SafeArea(
        child: Obx(() => c.isLoading.value
            ? const Center(
            child: CircularProgressIndicator(color: Colors.black))
            : RefreshIndicator(
          onRefresh: c.fetchAll,
          color: Colors.black,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [

                // ─── Header ───────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20.r),
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/home/Frame.png'),
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
                          'Welcome Back.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w900,
                            shadows: const [
                              Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  color: Colors.black26)
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Obx(() => Text(
                        //   c.bibleVerse.value.isNotEmpty
                        //       ? '"${c.bibleVerse.value}"'
                        //       : '',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 13.sp,
                        //     height: 1.4,
                        //     shadows: const [
                        //       Shadow(
                        //           offset: Offset(0, 1),
                        //           blurRadius: 2,
                        //           color: Colors.black26)
                        //     ],
                        //   ),
                        // )),
                        SizedBox(height: 16.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                                255, 255, 255, 0.5),
                            borderRadius:
                            BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1),
                                blurRadius: 8.r,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bible Verse',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Obx(() => Text(
                                c.bibleVerse.value.isNotEmpty
                                    ? '"${c.bibleVerse.value}"'
                                    : 'Loading verse...',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.sp,
                                  height: 1.5,
                                ),
                              )),
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

                    // ─── Mood Card ─────────────────────────
                    _SectionCard(
                      title: "What's your Mood Today",
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 12.h,

                            runSpacing: 12.h,
                            children: _moods.map((m) {
                              return _MoodItem(
                                label   : m['label']!,
                                emoji   : m['emoji']!,
                                moodKey : m['key']!,
                                selected: c.feeling,
                                onTap   : () => c.patchGoals(
                                    newFeeling: m['key']),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ─── Skin Status Card ──────────────────
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
                          physics:
                          const NeverScrollableScrollPhysics(),
                          children: _skinOptions.map((label) {
                            return _SkinChip(
                              label   : label,
                              selected: c.skinStatus,
                              onTap   : () => c.patchGoals(
                                  newSkinStatus: label),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ─── Water Intake Card ─────────────────
                    _SectionCard(
                      title: 'Water Intake',
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          Center(
                            child: Obx(() => Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 140.w,
                                  height: 140.w,
                                  child:
                                  CircularProgressIndicator(
                                    value: (c.waterPercentage.value.clamp(0, 100)) / 100,
                                    strokeWidth: 10.w,
                                    valueColor:
                                    const AlwaysStoppedAnimation(
                                        Color(0xFF333333)),
                                    backgroundColor:
                                    Colors.black12,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${c.waterAchieved.value} oz',
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '/ ${c.waterGoal.value} oz',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                          ),
                          SizedBox(height: 14.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                              BorderRadius.circular(24.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    borderRadius:
                                    BorderRadius.only(
                                      topLeft:
                                      Radius.circular(24.r),
                                      bottomLeft:
                                      Radius.circular(24.r),
                                    ),
                                    onTap: c.waterAchieved.value > 0 ? () => c.updateWaterAchieved(-8) : null,
                                    child:  c.waterAchieved.value > 0
                                        ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          const Icon(Icons.remove,
                                              color: Colors.white),
                                          SizedBox(width: 5.w),
                                          Text('8 oz',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize:
                                                  16.sp)),
                                        ],
                                      ),
                                    )
                                        : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          const Icon(Icons.remove,
                                              color: Colors.grey),
                                          SizedBox(width: 5.w),
                                          Text('8 oz',
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontSize:
                                                  16.sp)),
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                                Container(
                                    width: 1.w,
                                    height: 28.h,
                                    color: Colors.white24),
                                Expanded(
                                  child: InkWell(
                                    borderRadius:
                                    BorderRadius.only(
                                      topRight:
                                      Radius.circular(24.r),
                                      bottomRight:
                                      Radius.circular(24.r),
                                    ),
                                    onTap:c.waterAchieved.value < c.waterGoal.value ? () => c.updateWaterAchieved(8) : null,
                                    child: c.waterAchieved.value < c.waterGoal.value
                                        ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                          SizedBox(width: 5.w),
                                          Text('8 oz',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize:
                                                  16.sp)),
                                        ],
                                      ),
                                    )
                                        : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          const Icon(Icons.add,
                                              color: Colors.grey),
                                          SizedBox(width: 5.w),
                                          Text('8 oz',
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontSize:
                                                  16.sp)),

                                        ],
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ─── Notes Card ────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                            217, 217, 217, 1),
                        borderRadius:
                        BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.r, horizontal: 16.r),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Today's Notes",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                // ── edit / save icon ──────
                                Obx(() => c.isSavingNote.value
                                    ? Padding(
                                  padding: EdgeInsets.all(
                                      12.r),
                                  child: SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors
                                            .black54),
                                  ),
                                )
                                    : IconButton(
                                  icon: Icon(
                                    c.isEditingNote.value
                                        ? Icons.check
                                        : Icons.edit,
                                    size: 23.7.sp,
                                  ),
                                  onPressed: c.toggleNote,
                                )),
                              ],
                            ),

                            // ── note content ──────────────
                            Obx(() => c.isEditingNote.value
                                ? TextField(
                              controller: c.noteController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Type your today note ?',
                                hintStyle: TextStyle(
                                    color: const Color
                                        .fromRGBO(
                                        0, 0, 0, 0.4),
                                    fontSize: 16.sp),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      12.r),
                                  borderSide:
                                  BorderSide.none,
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(
                                    vertical: 12.r,
                                    horizontal: 16.r),
                                filled: true,
                                fillColor:
                                const Color.fromRGBO(
                                    255, 255, 255, 0.25),
                              ),
                            )
                                : Text(
                              c.noteText.value.isEmpty ? 'No notes for today. Tap edit to add some thoughts!' : c.noteText.value,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color
                                      .fromRGBO(
                                      0, 0, 0, 0.6)),
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

/* ═══════════════════ Reactive widgets ═══════════════════════════════════ */

class _MoodItem extends StatelessWidget {
  final String label;
  final String emoji;
  final String moodKey;
  final RxString selected;
  final VoidCallback onTap;

  const _MoodItem({
    required this.label,
    required this.emoji,
    required this.moodKey,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selected.value == moodKey;
      return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55.w,
              height: 55.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromRGBO(219, 234, 254, 1)
                    : const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(14.r),
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
                  fontSize: 12.sp,
                  color: Colors.black87,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SkinChip extends StatelessWidget {
  final String label;
  final RxString selected;
  final VoidCallback onTap;

  const _SkinChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selected.value == label;
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.black
                : const Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color:
              isSelected ? Colors.black : const Color(0xFFE5E5E5),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    });
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
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
          Text(title,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}