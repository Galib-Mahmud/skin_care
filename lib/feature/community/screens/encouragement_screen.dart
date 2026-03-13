import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/community/controller/community_controller.dart';

class EncouragementBoardScreen extends StatefulWidget {
  const EncouragementBoardScreen({super.key});

  @override
  State<EncouragementBoardScreen> createState() => _EncouragementBoardScreenState();
}

class _EncouragementBoardScreenState extends State<EncouragementBoardScreen> {
  final TextEditingController _controller = TextEditingController();
  final CommunityController communityController = Get.put(CommunityController());

  @override
  void initState() {
    String type = Get.arguments ?? 'prayer-requests';
    communityController.communityType.value = type;
    communityController.loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(16.w),
          elevation: 5,
          color: const Color.fromRGBO(217, 217, 217, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- FIXED HEADER SECTION ---
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 8.w, 16.h),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios, size: 16.sp, color: Colors.black87),
                    ),
                  ),
                  Text(
                    '✨ Encouragement Board',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // --- SCROLLABLE SECTION (Input + List) ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Input field
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: TextField(
                          controller: _controller,
                          minLines: 3,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Share words of encouragement...',
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 15.sp,
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                          ),
                        ),
                      ),

                      // Share Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:  () {
                              String content = _controller.text.trim();
                              if (content.isNotEmpty) {
                                communityController.createPosts(content, null);
                                _controller.clear();
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Please enter some encouragement to share.',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: Obx(() {
                              if (communityController.isCreating.value) {
                                return SizedBox(
                                  height: 16.h,
                                  width: 16.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return Text(
                                  'Share Encouragement',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            })
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Encouragements List
                      Obx(() {
                        if (communityController.postLists.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(child: Text('No encouragements yet.')),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: communityController.postLists.map((encouragement) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          encouragement.user ?? 'Unknown',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          encouragement.timeAgo ?? '',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      encouragement.postContent ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                        height: 1.8,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    InkWell(
                                      onTap: () {
                                        communityController.like(encouragement.id ?? 0);
                                      },
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.w),
                                        child: Row(
                                          children: [
                                            Icon(
                                              encouragement.isLikedByCurrentUser == true
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 20.sp,
                                              color: encouragement.isLikedByCurrentUser == true ? Colors.redAccent : Colors.black45,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              '${encouragement.totalLikes}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black26,
                                      thickness: 0.5,
                                      height: 32.h,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }),
                      SizedBox(height: 16.h), // Bottom padding for scroll
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}