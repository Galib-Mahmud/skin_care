import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/community/controller/community_controller.dart';
import '../models/post_list_model.dart';

class PrayerRequestsScreen extends StatefulWidget {
  const PrayerRequestsScreen({super.key});

  @override
  State<PrayerRequestsScreen> createState() => _PrayerRequestsScreenState();
}

class _PrayerRequestsScreenState extends State<PrayerRequestsScreen> {
  final CommunityController communityController = Get.put(CommunityController());
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    String type = Get.arguments ?? 'prayer-requests';
    communityController.communityType.value = type;
    communityController.loadPosts();
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
                  Text(
                    '🙏 Prayer Requests',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              // --- SCROLLABLE CONTENT ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Input Area
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: TextField(
                          controller: _controller,
                          minLines: 3,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Share a prayer request with the community...',
                            hintStyle: TextStyle(color: Colors.black26, fontSize: 15.sp),
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
                            onPressed: () {
                              if (_controller.text.trim().isNotEmpty) {
                                communityController.createPosts(_controller.text.trim(), null);
                                _controller.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(47, 46, 46, 1),
                                minimumSize: Size(double.infinity, 50.h)
                            ),
                            child: Obx(() => communityController.isCreating.value
                                ? SizedBox(height: 16.h, width: 16.h, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Text('Share Prayer Request', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Posts List
                      Obx(() {
                        if (communityController.postLists.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: const Center(child: Text("No posts found")),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: communityController.postLists.map((post) {
                              return _PrayerRequestCard(post: post);
                            }).toList(),
                          ),
                        );
                      }),
                      SizedBox(height: 20.h),
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
}

class _PrayerRequestCard extends StatelessWidget {
  final PostListModel post;
  const _PrayerRequestCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final CommunityController controller = Get.find<CommunityController>();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.user ?? "Unknown",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900, color: Colors.black87),
                  ),
                  Text(
                    post.timeAgo?.split(".").first ?? "",
                    style: TextStyle(fontSize: 12.sp, color: Colors.black45),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                post.postContent ?? "",
                style: TextStyle(fontSize: 14.sp, height: 1.6, color: Colors.black87),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  InkWell(
                    onTap: () => controller.like(post.id!),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            post.isLikedByCurrentUser == true ? Icons.favorite : Icons.favorite_border,
                            size: 16.sp,
                            color: post.isLikedByCurrentUser == true ? Colors.redAccent : Colors.black87,
                          ),
                          SizedBox(width: 6.w),
                          Text('Praying (${post.totalLikes ?? 0})', style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      controller.commentingPostId.value = post.id!;
                      controller.isCommenting.toggle();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 18.sp, color: Colors.black87),
                        SizedBox(width: 6.w),
                        Text('${post.totalComments ?? 0}', style: TextStyle(fontSize: 13.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // --- COMMENT SECTION ---
        Obx(() {
          if (controller.isCommenting.value && controller.commentingPostId.value == post.id) {
            final topLevelComments = post.comments!.where((c) => c.parentComment == null).toList();
            return Container(
              margin: EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.globalCommentTextController,
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.6),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.r), borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: controller.isCommentingInProgress.value
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.send),
                        onPressed: () => controller.comment(post.id!, null),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topLevelComments.length,
                    itemBuilder: (context, index) => _buildCommentItem(topLevelComments[index], post.id!, controller),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildCommentItem(CommentModel comment, int postId, CommunityController controller) {
    final replies = post.comments!.where((c) => c.parentComment == comment.id).toList();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.user ?? "User", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp)),
                SizedBox(height: 2.h),
                Text(comment.commentText ?? "", style: TextStyle(fontSize: 12.sp)),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.replyingCommentId.value = comment.id!;
                        controller.isReplying.toggle();
                      },
                      child: Text("Reply", style: TextStyle(color: Colors.blueAccent, fontSize: 12.sp)),
                    ),
                    SizedBox(width: 12.w),
                    Text(comment.timeAgo, style: TextStyle(color: Colors.black45, fontSize: 11.sp)),
                  ],
                ),

                // --- REPLY INPUT ---
                Obx(() => (controller.isReplying.value && controller.replyingCommentId.value == comment.id)
                    ? Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.commentTextController,
                          decoration: InputDecoration(
                            hintText: "Reply...",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, size: 18),
                        onPressed: () => controller.comment(postId, comment.id!),
                      ),
                    ],
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
          // Recursive Replies
          if (replies.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Column(
                children: replies.map((r) => _buildCommentItem(r, postId, controller)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}