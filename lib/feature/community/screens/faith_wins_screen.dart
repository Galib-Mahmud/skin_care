import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:skincare/feature/community/controller/community_controller.dart';

class FaithWinsTestimoniesScreen extends StatefulWidget {
  const FaithWinsTestimoniesScreen({super.key});

  @override
  State<FaithWinsTestimoniesScreen> createState() =>
      _FaithWinsTestimoniesScreenState();
}

class _FaithWinsTestimoniesScreenState
    extends State<FaithWinsTestimoniesScreen> {
  final TextEditingController _controller = TextEditingController();
  final CommunityController communityController =
  Get.put(CommunityController());

  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();

    String type = Get.arguments ?? 'prayer-requests';
    communityController.communityType.value = type;
    communityController.loadPosts();
  }

  /// Pick image from gallery
  Future<void> _pickImage() async {
    final XFile? picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });
    }
  }

  /// Pick image from camera
  Future<void> _pickCamera() async {
    final XFile? picked =
    await ImagePicker().pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });
    }
  }

  /// Send Post
  void _sendPost() async {
    final text = _controller.text.trim();

    if (text.isEmpty && _selectedImage == null) {
      Get.snackbar(
        "Empty Post",
        "Please write something or add an image",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await communityController.createPosts(
        text,
        _selectedImage?.path,
      );

      /// Clear input after success
      _controller.clear();

      setState(() {
        _selectedImage = null;
      });

      FocusScope.of(context).unfocus();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to create post",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => ListView(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
            children: [
              /// Post Create Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite,
                              size: 18.sp, color: Colors.black87),
                          SizedBox(width: 6.w),
                          Text(
                            'Faith Wins & Testimonies',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      /// Text Field
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Share faith wins & testimonies...',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: 14.sp),
                            contentPadding: EdgeInsets.all(16.w),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      /// Selected Image Indicator
                      if (_selectedImage != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  height: 80.h,
                                  width: 80.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImage = null;
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: const Icon(Icons.close,
                                        size: 16, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      /// Image Buttons
                      Row(
                        children: [
                          IconButton(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image_outlined),
                          ),
                          SizedBox(width: 16.w),
                          IconButton(
                            onPressed: _pickCamera,
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      /// Share Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _sendPost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: communityController.isCreating.value
                              ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            'Share Prayer Request',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// Post List
              ...communityController.postLists.map((post) {
                return _buildPostCard(post);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  /// Post Card
  Widget _buildPostCard(dynamic post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.user ?? "Unknown",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),

            SizedBox(height: 8.h),

            ReadMoreText(
              post.postContent ?? '',
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
            ),

            SizedBox(height: 10.h),

            if (post.postImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  post.postImage,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            SizedBox(height: 10.h),

            /// Like Button
            InkWell(
              onTap: () {
                communityController.like(post.id);
              },
              child: Row(
                children: [
                  Icon(
                    post.isLikedByCurrentUser == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text('${post.totalLikes ?? 0}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}