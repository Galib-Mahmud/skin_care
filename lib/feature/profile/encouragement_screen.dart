import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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


      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0, bottom: 10.0),
        child: Card(
          elevation: 5,
          color: Color.fromRGBO(217, 217, 217, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),

              Center(
                child: Text(
                  'Encouragement Board',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Input field to share encouragement
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Share words of encouragement...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 13.sp,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                  ),
                ),
              ),

              // Share Encouragement Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ElevatedButton(
                  onPressed: () {
                    String content = _controller.text.trim();
                    if (content.isNotEmpty) {
                      communityController.createPosts(
                        content , null
                      );
                      _controller.clear();
                    } else {
                      Get.snackbar('Error', 'Please enter some encouragement to share.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                  ),
                  child: Obx(
                      (){
                        if(communityController.isCreating.value){
                          return SizedBox(
                            height: 16.h,
                            width: 16.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return Text(
                            'Share Encouragement',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }
                      }
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Encouragements List
              Obx(
                  (){
                    if (communityController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (communityController.postLists.isEmpty) {
                      return Center(child: Text('No encouragements yet. Be the first to share!'));
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: communityController.postLists.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final encouragement = communityController.postLists[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.4),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name + Timestamp header
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        encouragement.user ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        encouragement.timeAgo ?? '',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10.h),

                                  // Message
                                  Text(
                                    encouragement.postContent ?? '',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  // Like button
                                  InkWell(
                                    onTap: () {
                                      // onLikeChanged(!encouragement.isLiked);
                                    },
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            size: 16.sp,
                                            color: Colors.black87,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${encouragement.totalLikes}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}