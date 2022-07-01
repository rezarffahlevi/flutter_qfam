class ThreadsModel {
  int? id;
  String? uuid;
  String? content;
  int? forumId;
  int? contentId;
  String? createdBy;
  int? parentId;
  int? isAnonymous;
  int? countComments;
  int? countLikes;
  int? isLiked;
  String? createdAt;
  String? updatedAt;
  List<ThreadsModel>? child;

  ThreadsModel(
      {this.id,
      this.uuid,
      this.content,
      this.forumId,
      this.contentId,
      this.createdBy,
      this.parentId,
      this.isAnonymous,
      this.countComments,
      this.countLikes,
      this.isLiked,
      this.createdAt,
      this.updatedAt,
      this.child});

  ThreadsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    content = json['content'];
    forumId = json['forum_id'];
    contentId = json['content_id'];
    createdBy = json['created_by'];
    parentId = json['parent_id'];
    isAnonymous = json['is_anonymous'];
    countComments = json['count_comments'];
    countLikes = json['count_likes'];
    isLiked = json['is_liked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['child'] != null) {
      child = <ThreadsModel>[];
      json['child'].forEach((v) {
        child!.add(new ThreadsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['content'] = this.content;
    data['forum_id'] = this.forumId;
    data['content_id'] = this.contentId;
    data['created_by'] = this.createdBy;
    data['parent_id'] = this.parentId;
    data['is_anonymous'] = this.isAnonymous;
    data['count_comments'] = this.countComments;
    data['count_likes'] = this.countLikes;
    data['is_liked'] = this.isLiked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
