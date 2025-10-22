import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerRequestsScreen extends StatefulWidget {
  const PrayerRequestsScreen({super.key});

  @override
  State<PrayerRequestsScreen> createState() => _PrayerRequestsScreenState();
}

class _PrayerRequestsScreenState extends State<PrayerRequestsScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_PrayerRequest> _requests = [
    _PrayerRequest(
      'Sarah M.',
      '2 hours ago',
      'Please pray for my confidence as I start my new skincare journey. I have struggled with acne for years.',
      15,
      comments: [],
    ),
    _PrayerRequest(
      'Lisa K.',
      '5 hours ago',
      'Grateful for clear skin this week! Please pray for continued healing and self-love.',
      12,
      comments: [],
    ),
    _PrayerRequest(
      'Courtney Henry',
      '1 day ago',
      'Wishing you all the confidence and self-love on your skincare journey! You\'ve got this — healing takes time, but you\'re moving forward counts. 🙏',
      30,
      hasProfilePic: true,
      comments: [
        _Comment('Ronald Richards', 'Thank you so much that really means a lot to me', 6),
      ],
    ),
  ];

  void _showCommentSheet(BuildContext context, _PrayerRequest request) {
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),

              // Original Post
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (request.hasProfilePic)
                          Container(
                            width: 36.w,
                            height: 36.w,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.pink, Colors.orange],
                              ),
                            ),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              request.timestamp,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      request.message,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Comments List
              Expanded(
                child: request.comments.isEmpty
                    ? Center(
                  child: Text(
                    'No comments yet. Be the first to comment!',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black45,
                    ),
                  ),
                )
                    : ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: request.comments.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, i) => _CommentWidget(
                    comment: request.comments[i],
                    onLikeChanged: (isLiked) {
                      setModalState(() {
                        setState(() {
                          request.comments[i].isLiked = isLiked;
                          if (isLiked) {
                            request.comments[i].likes++;
                          } else {
                            request.comments[i].likes--;
                          }
                        });
                      });
                    },
                  ),
                ),
              ),

              // Comment Input
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 12.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black38,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          setModalState(() {
                            setState(() {
                              request.comments.add(
                                _Comment(
                                  'You',
                                  commentController.text,
                                  0,
                                ),
                              );
                              commentController.clear();
                            });
                          });
                          FocusScope.of(context).unfocus();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🙏', style: TextStyle(fontSize: 20.sp)),
                  SizedBox(width: 8.w),
                  Text(

                    'Prayer Requests',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Input Container
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Input field
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
                                hintText: 'Share a prayer request with the community...',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.sp,
                                ),
                                contentPadding: EdgeInsets.all(16.w),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Share Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  setState(() {
                                    _requests.insert(
                                      0,
                                      _PrayerRequest(
                                        'You',
                                        'Just Now',
                                        _controller.text,
                                        0,
                                        comments: [],
                                      ),
                                    );
                                    _controller.clear();
                                  });
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                elevation: 0,
                              ),
                              child: Text(
                                'Share Prayer Request',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Prayer Requests List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: _requests.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, i) => _PrayerRequestCard(
                        request: _requests[i],
                        onPrayingChanged: (isPraying) {
                          setState(() {
                            _requests[i].isPraying = isPraying;
                            if (isPraying) {
                              _requests[i].prayingCount++;
                            } else {
                              _requests[i].prayingCount--;
                            }
                          });
                        },
                        onCommentTap: () => _showCommentSheet(context, _requests[i]),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Load More Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Load more logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            elevation: 0,
                          ),
                          child: Text(
                            'Load 19 more comments',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// --- Model for Comment ---
class _Comment {
  final String name;
  final String message;
  int likes;
  bool isLiked;

  _Comment(this.name, this.message, this.likes, {this.isLiked = false});
}

/// --- Model for Prayer Request ---
class _PrayerRequest {
  final String name;
  final String timestamp;
  final String message;
  int prayingCount;
  bool isPraying;
  final bool hasProfilePic;
  final List<_Comment> comments;

  _PrayerRequest(
      this.name,
      this.timestamp,
      this.message,
      this.prayingCount, {
        this.isPraying = false,
        this.hasProfilePic = false,
        required this.comments,
      });
}

/// --- Prayer Request Card ---
class _PrayerRequestCard extends StatelessWidget {
  const _PrayerRequestCard({
    required this.request,
    required this.onPrayingChanged,
    required this.onCommentTap,
  });

  final _PrayerRequest request;
  final Function(bool) onPrayingChanged;
  final VoidCallback onCommentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with profile pic, name, timestamp
          Row(
            children: [
              if (request.hasProfilePic)
                Container(
                  width: 40.w,
                  height: 40.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink, Colors.orange],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      request.timestamp,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Prayer request message
          Text(
            request.message,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),

          SizedBox(height: 14.h),

          // Action buttons row
          Row(
            children: [
              // Praying button
              InkWell(
                onTap: () {
                  onPrayingChanged(!request.isPraying);
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(

                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(7.r),

                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        request.isPraying ? Icons.favorite : Icons.favorite_border,
                        size: 16.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Praying (${request.prayingCount})',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Spacer(),

              // Comment button
              InkWell(
                onTap: onCommentTap,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: 18.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          // Comments preview section
          if (request.comments.isNotEmpty) ...[
            SizedBox(height: 16.h),
            InkWell(
              onTap: onCommentTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...request.comments.take(2).map((comment) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(right: 8.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.name,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                comment.message,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  if (request.comments.length > 2)
                    Text(
                      'View all ${request.comments.length} comments',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// --- Comment Widget ---
class _CommentWidget extends StatelessWidget {
  const _CommentWidget({
    required this.comment,
    required this.onLikeChanged,
  });

  final _Comment comment;
  final Function(bool) onLikeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile pic
        Container(
          width: 36.w,
          height: 36.w,
          margin: EdgeInsets.only(right: 12.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
        ),

        // Comment content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                comment.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  InkWell(
                    onTap: () => onLikeChanged(!comment.isLiked),
                    child: Text(
                      comment.isLiked ? 'Liked' : 'Like',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: comment.isLiked ? Colors.red : Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '•',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Reply',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (comment.likes > 0) ...[
                    SizedBox(width: 4.w),
                    Text(
                      '•',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${comment.likes}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}