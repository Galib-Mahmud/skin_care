import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/route_name.dart';

class FaithWinsTestimoniesScreen extends StatefulWidget {
  const FaithWinsTestimoniesScreen({super.key});

  @override
  State<FaithWinsTestimoniesScreen> createState() =>
      _FaithWinsTestimoniesScreenState();
}

class _FaithWinsTestimoniesScreenState
    extends State<FaithWinsTestimoniesScreen> {
  final TextEditingController _controller = TextEditingController();
  XFile? _selectedImage;
  XFile? _selectedVideo;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _selectedVideo = pickedFile;
    });
  }

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty || _selectedImage != null || _selectedVideo != null) {
      print(
          'Sending: Text: $text, Image: ${_selectedImage?.path}, Video: ${_selectedVideo?.path}');
      _controller.clear();
      setState(() {
        _selectedImage = null;
        _selectedVideo = null;
      });
    }
  }

  final List<_Testimony> _testimonies = [
    _Testimony(
      'Maria R.',
      '1 week ago',
      '6 Months of Faith & Clear Skin',
      'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!',
      10,
    ),
    _Testimony(
      'Nam S.',
      '1 week ago',
      '6 Months of Faith & Clear Skin',
      'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!',
      7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header Section (Input Card)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 18.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Faith Wins & Testimonies',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Input box
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Share Faith Wins & Testimonies...',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 13.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      prefixIcon: Icon(
                        Icons.edit_outlined,
                        color: Colors.black54,
                        size: 20.sp,
                      ),
                    ),
                    maxLines: null,
                    minLines: 1,
                  ),

                  SizedBox(height: 10.h),

                  // Action buttons row
                  Row(
                    children: [
                      IconButton(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image_outlined, color: Colors.black87),
                        iconSize: 22.sp,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        onPressed: _pickVideo,
                        icon: Icon(Icons.videocam_outlined, color: Colors.black87),
                        iconSize: 22.sp,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Full-width Share Button
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
                        elevation: 0,
                      ),
                      child: Text(
                        'Share Prayer Request',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Testimonies List
            ...List.generate(
              _testimonies.length,
                  (i) => Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                ),
                child: _TestimonyCard(
                  testimony: _testimonies[i],
                  onLikeChanged: (isLiked) {
                    setState(() {
                      _testimonies[i].isLiked = isLiked;
                      _testimonies[i].likeCount += isLiked ? 1 : -1;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// --- Model ---
class _Testimony {
  final String name;
  final String timestamp;
  final String title;
  final String message;
  int likeCount;
  bool isLiked;

  _Testimony(
      this.name,
      this.timestamp,
      this.title,
      this.message,
      this.likeCount, {
        this.isLiked = false,
      });
}

/// --- Card Widget ---
class _TestimonyCard extends StatelessWidget {
  const _TestimonyCard({
    required this.testimony,
    required this.onLikeChanged,
  });

  final _Testimony testimony;
  final Function(bool) onLikeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                testimony.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                testimony.timestamp,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Text(
            testimony.title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            testimony.message,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),

          SizedBox(height: 12.h),

          // Image with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/shop/story.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180.h,
                ),
              ),
              // Dimensions overlay
              Positioned(
                bottom: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '281 × 258',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Buttons
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.toNamed(RouteName.fullStory);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black87, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'Read Full Story',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () => onLikeChanged(!testimony.isLiked),
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      Icon(
                        testimony.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${testimony.likeCount}',
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
        ],
      ),
    );
  }
}