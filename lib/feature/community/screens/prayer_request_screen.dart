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
        child: Column(
          children: [

            /// HEADER
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
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    /// CREATE POST
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [

                          TextField(
                            controller: _controller,
                            maxLines: 3,
                            decoration: InputDecoration(
                              fillColor:Colors.white.withOpacity(0.3),
                              hintText:
                              'Share a prayer request with the community...',
                              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {

                                if (_controller.text.isEmpty) return;
                                communityController.createPosts(
                                  _controller.text, null
                                );

                                _controller.clear();

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                              ),
                              child: Obx(
                                () => communityController.isCreating.value ? SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : Text(
                                  "Share Prayer Request",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.white
                                )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// POSTS LIST
                    Obx(() {

                      if (communityController.postLists.isEmpty) {

                        return Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Center(
                            child: Text("No posts found"),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: communityController.postLists.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, i) {

                          final post = communityController.postLists[i];

                          return _PrayerRequestCard(
                            post: post,
                            onLikeTap: () {

                              /// TODO: Like API
                              // communityController.likePost(post.id);

                            },
                          );
                        },
                      );
                    }),

                    SizedBox(height: 30.h)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/// POST CARD
class _PrayerRequestCard extends StatelessWidget {
  final PostListModel post;
  final VoidCallback onLikeTap;

  const _PrayerRequestCard({
    required this.post,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    final CommunityController communityController = Get.put(CommunityController());

    /// Recursive comment widget to show nested replies
    Widget _buildComment(CommentModel comment) {
      final children = post.comments!
          .where((c) => c.parentComment == comment.id)
          .toList();

      return Padding(
        padding: EdgeInsets.only(left: comment.parentComment == null ? 0 : 20.w, top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user ?? "Unknown",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    comment.commentText ?? "",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          communityController.replyingCommentId.value = comment.id!;
                          communityController.isReplying.value =
                          !communityController.isReplying.value;
                        },
                        child: Text(
                          "Reply",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        comment.createdAt
                            ?.replaceAll("T", " ")
                            .split(".")
                            .first ??
                            "",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  // Individual reply input
                  if (communityController.isReplying.value &&
                      communityController.replyingCommentId.value == comment.id)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // controller: communityController.replyController,
                              // TODO:: Implement separate controllers for each comment if needed
                              decoration: InputDecoration(
                                hintText: "Write a reply...",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, size: 20.sp),
                            onPressed: () {
                              // if (communityController.replyController.text.trim().isEmpty) return;
                              //
                              // communityController.addReply(
                              //     post,
                              //     comment.id,
                              //     communityController.replyController.text.trim());
                              //
                              // communityController.replyController.clear();
                              // communityController.isReplying.value = false;
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Nested replies
            ...children.map((c) => _buildComment(c)).toList(),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// USER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.user ?? "Unknown",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    post.updatedAt?.replaceAll("T", " ").split(".").first ?? "",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              /// MESSAGE
              Text(
                post.postContent ?? "",
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 14.h),
              /// ACTIONS
              Row(
                children: [
                  /// LIKE
                  InkWell(
                    onTap: onLikeTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border, size: 16.sp),
                          SizedBox(width: 6.w),
                          Text(
                            "Praying (${post.totalLikes ?? 0})",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  /// COMMENT
                  InkWell(
                    onTap: () {
                      communityController.isCommenting.value =
                      !communityController.isCommenting.value;
                      communityController.commentingPostId.value = post.id!;
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 18.sp),
                        SizedBox(width: 6.w),
                        Text(
                          "${post.totalComments ?? 0}",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Comment section
        Obx(() {
          if (communityController.isCommenting.value &&
              communityController.commentingPostId.value == post.id) {
            final topLevelComments =
            post.comments!.where((c) => c.parentComment == null).toList();

            return Column(
              children: [
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        // controller: communityController.replyController,
                        // TODO:: Implement separate controllers for each comment if needed
                        decoration: InputDecoration(
                          hintText: "Write a reply...",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, size: 20.sp),
                      onPressed: () {
                        // if (communityController.globalCommentController.text
                        //     .trim()
                        //     .isEmpty) return;
                        //
                        // communityController.addComment(
                        //     post,
                        //     communityController.globalCommentController.text
                        //         .trim());
                        //
                        // communityController.globalCommentController.clear();
                      },
                    ),
                  ],
                ),

                /// Comments list
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 0.w, top: 8.h),
                  children: topLevelComments.map((c) => _buildComment(c)).toList(),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}