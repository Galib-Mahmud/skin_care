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
  State<FaithWinsTestimoniesScreen> createState() => _FaithWinsTestimoniesScreenState();
}

class _FaithWinsTestimoniesScreenState extends State<FaithWinsTestimoniesScreen> {
  final TextEditingController _controller = TextEditingController();
  final CommunityController communityController = Get.put(CommunityController());
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    String type = Get.arguments ?? 'testimonies'; // Default to testimonies
    communityController.communityType.value = type;
    communityController.loadPosts();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _sendPost() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedImage == null) {
      Get.snackbar("Empty Post", "Please write something or add an image", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    await communityController.createPosts(text, _selectedImage?.path);
    _controller.clear();
    setState(() => _selectedImage = null);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0x00000040),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- FIXED HEADER ---
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 8.w, 16.h),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios, size: 16.sp, color: Colors.black87),
                    ),
                  ),
                  Icon(Icons.favorite, size: 18.sp, color: Colors.black87),
                  SizedBox(width: 8.w),
                  Text(
                    'Faith Wins & Testimonies',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ],
              ),

              // --- SCROLLABLE CONTENT ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Create Post Section
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _controller,
                              minLines: 3,
                              maxLines: null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                                hintText: 'Share faith wins & testimonies...',
                                hintStyle: TextStyle(color: Colors.black26, fontSize: 15.sp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            if (_selectedImage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(File(_selectedImage!.path), height: 100.h, width: 100.w, fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      right: 0, top: 0,
                                      child: GestureDetector(
                                        onTap: () => setState(() => _selectedImage = null),
                                        child: CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: () => _pickImage(ImageSource.gallery), icon: Icon(Icons.attach_file, color: Colors.black54, size: 20,)),
                                IconButton(onPressed: () => _pickImage(ImageSource.camera), icon: Icon(Icons.camera_alt_outlined, color: Colors.black54, size: 20)),
                              ],
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _sendPost,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(47, 46, 46, 1),
                              minimumSize: Size(double.infinity, 50.h),
                            ),
                            child: Obx(() => communityController.isCreating.value
                                ? SizedBox(height: 16.h, width: 16.h, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Text('Share Testimony', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp))),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Post List
                      Obx(() {
                        return Column(
                          children: communityController.postLists.map((post) => _buildPostCard(post)).toList(),
                        );
                      }),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(dynamic post) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0x00000040),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(post.user ?? "Unknown", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900, color: Colors.black87)),
                Text(post.timeAgo ?? "", style: TextStyle(fontSize: 11.sp, color: Colors.black45)),
              ],
            ),
            SizedBox(height: 10.h),
            ReadMoreText(
              post.postContent ?? '',
              trimLines: 3,
              style: TextStyle(fontSize: 14.sp, height: 1.8, color: Colors.black87),
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              moreStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            if (post.postImage != null)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(post.postImage, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
            SizedBox(height: 14.h),
            InkWell(
              onTap: () => communityController.like(post.id),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(post.isLikedByCurrentUser == true ? Icons.favorite : Icons.favorite_border, size: 18.sp, color: post.isLikedByCurrentUser == true ? Colors.red : Colors.black54),
                  SizedBox(width: 6.w),
                  Text('${post.totalLikes ?? 0}', style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}