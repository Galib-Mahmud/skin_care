import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaithWinsTestimoniesScreen extends StatefulWidget {
  const FaithWinsTestimoniesScreen({super.key});

  @override
  State<FaithWinsTestimoniesScreen> createState() => _FaithWinsTestimoniesScreenState();
}

class _FaithWinsTestimoniesScreenState extends State<FaithWinsTestimoniesScreen> {
  final List<_Testimony> _testimonies = [
    _Testimony(
      'Maria R.',
      '1 week ago',
      '6 Months of Faith & Clear Skin',
      'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!',
      10,
    ),
    _Testimony(
      'Maria R.',
      '1 week ago',
      '6 Months of Faith & Clear Skin',
      'Through prayer, patience, and gentle skincare, God has blessed me with the confidence I never thought I\'d have!',
      10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 20.sp,
                  color: Colors.black87,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Faith Wins & Testimonies',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: _testimonies.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, i) => _TestimonyCard(
          testimony: _testimonies[i],
          onLikeChanged: (isLiked) {
            setState(() {
              _testimonies[i].isLiked = isLiked;
              if (isLiked) {
                _testimonies[i].likeCount++;
              } else {
                _testimonies[i].likeCount--;
              }
            });
          },
        ),
      ),
    );
  }
}

/// --- Model for Testimony ---
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

/// --- Testimony Card ---
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

          SizedBox(height: 12.h),

          // Title
          Text(
            testimony.title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8.h),

          // Message
          Text(
            testimony.message,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          SizedBox(height: 12.h),

          // Read Full Story button and Like
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Read full story action
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.black87,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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

              // Like button
              InkWell(
                onTap: () {
                  onLikeChanged(!testimony.isLiked);
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      Icon(
                        testimony.isLiked ? Icons.favorite : Icons.favorite_border,
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