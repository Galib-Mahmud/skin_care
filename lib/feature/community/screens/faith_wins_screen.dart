import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:skincare/feature/community/controller/community_controller.dart';

import '../../../routes/route_name.dart';

class FaithWinsTestimoniesScreen extends StatefulWidget {
  const FaithWinsTestimoniesScreen({super.key});

  @override
  State<FaithWinsTestimoniesScreen> createState() =>
      _FaithWinsTestimoniesScreenState();
}

class _FaithWinsTestimoniesScreenState
    extends State<FaithWinsTestimoniesScreen> {
  final TextEditingController _controller = TextEditingController();
  final CommunityController communityController = Get.put(CommunityController());
  XFile? _selectedImage;
  XFile? _selectedVideo;

  @override
  void initState() {
    super.initState();

    String type = Get.arguments ?? 'prayer-requests';
    communityController.communityType.value = type;
    communityController.loadPosts();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = pickedFile);
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedVideo = pickedFile);
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedImage == null && _selectedVideo == null) return;

    print(
        'Send -> Text: $text, Image: ${_selectedImage?.path}, Video: ${_selectedVideo?.path}');
    _controller.clear();
    setState(() {
      _selectedImage = null;
      _selectedVideo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => ListView(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
            children: [
              // Header input card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, size: 18.sp, color: Colors.black87),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLines: 3,
                          decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.02),
                            hintText: 'Share faith wins & testimonies...',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontSize: 14.sp),
                            contentPadding: EdgeInsets.all(16.w),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          IconButton(
                              onPressed: _pickImage,
                              icon: Icon(Icons.image_outlined,
                                  color: Colors.black87)),
                          SizedBox(width: 16.w),
                          IconButton(
                              onPressed: _pickVideo,
                              icon: Icon(Icons.videocam_outlined,
                                  color: Colors.black87)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
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

              // Post list
              ...communityController.postLists.map((post) {
                return _buildPostCard(post);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(dynamic post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.user ?? 'Unknown User',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                Text(
                  post.timeAgo ?? '',
                  style: TextStyle(fontSize: 11.sp, color: Colors.black45),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ReadMoreText(
              post.postContent ?? '',
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                post.postImage ??
                    'https://via.placeholder.com/400x200.png?text=No+Image',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180.h,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180.h,
                    color: Colors.black12,
                    child: Center(child: Icon(Icons.broken_image, size: 40.sp)),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            // Actions
            Row(
              children: [
                // OutlinedButton(
                //   onPressed: () => Get.toNamed(RouteName.fullStory),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: Colors.black87, width: 1.2),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(6.r),
                //     ),
                //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                //     backgroundColor: Colors.white,
                //   ),
                //   child: Text('Read Full Story',
                //       style: TextStyle(
                //           fontSize: 11.sp,
                //           color: Colors.black87,
                //           fontWeight: FontWeight.w500)),
                // ),
                // Spacer(),
                InkWell(
                  onTap: () => null,
                  child: Row(
                    children: [
                      Icon(
                        post.isLikedByCurrentUser == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                          size: 18.sp,
                          color: Colors.black87),
                      SizedBox(width: 4.w),
                      Text('${post.totalLikes ?? 0}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}