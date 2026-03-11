import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/chat_bot/models/chat_history_model.dart';
import 'package:skincare/feature/community/models/post_list_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';

class CommunityController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  TextEditingController commentTextController = TextEditingController();
  TextEditingController globalCommentTextController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString communityType = 'prayer-requests'.obs;


  final RxList<PostListModel> postLists = <PostListModel>[].obs;
  final RxBool isCreating = false.obs;
  final RxList<ChatHistoryModel> chatHistory = <ChatHistoryModel>[].obs;

  final RxBool isCommenting = false.obs;
  final RxBool isCommentingInProgress = false.obs;
  final RxInt commentingPostId = 0.obs;

  final RxBool isReplying = false.obs;
  final RxBool isReplyingInProgress = false.obs;
  final RxInt replyingCommentId = 0.obs;


  Future<void> createPosts(String content, String? images) async {
    isCreating.value = true;
    print("🔍 Creating post for bot type: ${communityType.value}");

    final Map<String, dynamic> bodyWithImage = {
      'post_content': content,
      'images': images,
      'post_image': communityType.value,
    };

    final Map<String, dynamic> bodyWithoutImage = {
      'post_content': content,
      'post_type': communityType.value,
    };

    try {
      final token = await UserInfo.getAccessToken();
      final response = await http.post(
        Uri.parse(ApiEndpoint.createPost),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: images != null ? jsonEncode(bodyWithImage) : jsonEncode(bodyWithoutImage),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Post created successfully: ${response.body}");
        await loadPosts(); // Refresh the post list after creation
      } else {
        print("❌ Failed to create post: ${response.statusCode} - ${response.body}");
      }


    } catch (e) {
      print('❌ Failed to create post: $e');
    } finally {
      isCreating.value = false;
    }
  }

  Future<void> like(int id) async {
    try {
      final token = await UserInfo.getAccessToken();
      final response = await http.post(
        Uri.parse(ApiEndpoint.likes),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "post" : id.toString()
        }
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await loadPosts();
      } else {
        print("❌ Failed to like post: ${response.statusCode} - ${response.body}");
      }

    } catch (e) {
      print('❌ Failed to like post: $e');
    } finally {
    }
  }

  Future<void> comment(int id, int? parentID) async {

    if(parentID != null) {
      isReplyingInProgress.value = true;
      replyingCommentId.value = parentID;
    } else {
      isCommentingInProgress.value = true;
      commentingPostId.value = id;
    }

    print("🔍 Commenting on post ID: $id with parent comment ID: ${parentID ?? 'None'}");

    final Map<String, String> bodyWithOutParent = {
      "post": id.toString(),
      "comment_text": globalCommentTextController.text,
    };

    final Map<String, String> bodyWithParent = {
      "post": id.toString(),
      "comment_text": commentTextController.text,
      "parent_comment": parentID.toString(),
    };

    try {
      final token = await UserInfo.getAccessToken();
      final response = await http.post(
          Uri.parse(ApiEndpoint.comments),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: parentID != null ? jsonEncode(bodyWithParent) : jsonEncode(bodyWithOutParent)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
          commentTextController.clear();
          await loadPosts();

          if(parentID != null) {
            isReplying.value = !isReplying.value;
          }
      } else {
        print("❌ Failed to comment post: ${response.statusCode} - ${response.body}");
      }

    } catch (e) {
      print('❌ Failed to comment post: $e');
    } finally {
      commentTextController.clear();
      globalCommentTextController.clear();
        if(parentID != null) {
          isReplyingInProgress.value = false;
        } else {
          isCommentingInProgress.value = false;
        }
    }
  }

  Future<void> loadPosts() async {
    isLoading.value = true;

    print("🔍 Loading chat history for bot type: ${communityType.value}");

    try {
      final response = await _apiClient.get(
        "${ApiEndpoint.listPosts}?bot_type=${communityType.value}",
        requiresAuth: true,
      );

      if (response != null && response is List) {
        postLists.value =
            response.map((post) => PostListModel.fromJson(post)).toList();

        print("✅ Loaded ${postLists.length} posts for type: ${communityType.value}");
      }
    } catch (e) {
      print('❌ Failed to load chat history: $e');
    } finally {
      isLoading.value = false;
    }
  }


}