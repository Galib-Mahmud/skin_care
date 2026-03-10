class PostListModel {
  int? id;
  String? user;
  String? postType;
  String? postContent;
  String? postImage;
  String? createdAt;
  String? updatedAt;
  int? totalLikes;
  int? totalComments;
  List<CommentModel>? comments;

  PostListModel({
    this.id,
    this.user,
    this.postType,
    this.postContent,
    this.postImage,
    this.createdAt,
    this.updatedAt,
    this.totalLikes,
    this.totalComments,
    this.comments,
  });

  PostListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    postType = json['post_type'];
    postContent = json['post_content'];
    postImage = json['post_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalLikes = json['total_likes'];
    totalComments = json['total_comments'];

    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments!.add(CommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user'] = user;
    data['post_type'] = postType;
    data['post_content'] = postContent;
    data['post_image'] = postImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_likes'] = totalLikes;
    data['total_comments'] = totalComments;

    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  /// New getter: returns relative "time ago" for updatedAt
  String get timeAgo {
    if (updatedAt == null) return "";
    final date = DateTime.parse(updatedAt!).toLocal();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) return "${difference.inSeconds}s ago";
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inHours}h ago";
    if (difference.inDays < 7) return "${difference.inDays}d ago";
    if (difference.inDays < 30) return "${(difference.inDays / 7).floor()}w ago";
    if (difference.inDays < 365) return "${(difference.inDays / 30).floor()}mo ago";
    return "${(difference.inDays / 365).floor()}y ago";
  }
}

class CommentModel {
  int? id;
  String? user;
  int? parentComment;
  String? commentText;
  String? createdAt;
  String? parentCommentText;

  CommentModel({
    this.id,
    this.user,
    this.parentComment,
    this.commentText,
    this.createdAt,
    this.parentCommentText,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    parentComment = json['parent_comment'];
    commentText = json['comment_text'];
    createdAt = json['created_at'];
    parentCommentText = json['parent_comment_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user'] = user;
    data['parent_comment'] = parentComment;
    data['comment_text'] = commentText;
    data['created_at'] = createdAt;
    data['parent_comment_text'] = parentCommentText;
    return data;
  }

  /// New getter: returns relative "time ago" for comment
  String get timeAgo {
    if (createdAt == null) return "";
    final date = DateTime.parse(createdAt!).toLocal();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) return "${difference.inSeconds}s ago";
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inHours}h ago";
    if (difference.inDays < 7) return "${difference.inDays}d ago";
    if (difference.inDays < 30) return "${(difference.inDays / 7).floor()}w ago";
    if (difference.inDays < 365) return "${(difference.inDays / 30).floor()}mo ago";
    return "${(difference.inDays / 365).floor()}y ago";
  }
}