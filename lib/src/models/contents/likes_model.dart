class LikesModel {
  int? id;
  int? contentId;
  int? threadId;
  int? userId;
  String? contentText;
  String? threadText;
  String? contentUuid;
  String? threadUuid;

  LikesModel({
    this.id,
    this.contentId,
    this.threadId,
    this.userId,
    this.contentText,
    this.threadText,
    this.contentUuid,
    this.threadUuid,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentId = json['content_id'];
    threadId = json['thread_id'];
    userId = json['user_id'];
    contentText = json['content_text'];
    threadText = json['thread_text'];
    contentUuid = json['content_uuid'];
    threadUuid = json['thread_uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content_id'] = this.contentId;
    data['thread_id'] = this.threadId;
    data['user_id'] = this.userId;
    data['content_text'] = this.contentText;
    data['thread_text'] = this.threadText;
    data['content_uuid'] = this.contentUuid;
    data['thread_uuid'] = this.threadUuid;
    return data;
  }
}
