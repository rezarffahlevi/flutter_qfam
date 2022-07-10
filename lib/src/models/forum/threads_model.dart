class ThreadsModel {
  int? id;
  String? uuid;
  String? content;
  String? image;
  int? forumId;
  int? contentId;
  dynamic createdBy;
  String? createdByName;
  String? createdByPhoto;
  String? createdByRole;
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
      this.image,
      this.forumId,
      this.contentId,
      this.createdBy,
      this.createdByName,
      this.createdByPhoto,
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
    image = json['image'];
    forumId = json['forum_id'];
    contentId = json['content_id'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    createdByPhoto = json['created_by_photo'];
    createdByRole = json['created_by_role'];
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
    data['image'] = this.image;
    data['forum_id'] = this.forumId;
    data['content_id'] = this.contentId;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    data['created_by_photo'] = this.createdByPhoto;
    data['created_by_role'] = this.createdByRole;
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
