class ChatHistoryModel {
  int? id;
  int? session;
  String? role;
  String? message;
  String? createdAt;

  ChatHistoryModel(
      {this.id, this.session, this.role, this.message, this.createdAt});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    role = json['role'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session'] = this.session;
    data['role'] = this.role;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
