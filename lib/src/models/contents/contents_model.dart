class ContentsModel {
  int? id;
  String? uuid;
  String? title;
  String? content;
  String? thumbnail;
  int? categoryId;
  String? category;
  int? sectionId;
  String? link;
  String? tags;
  String? status;
  int? isVideo;
  int? isExternal;
  int? createdBy;
  String? createdByName;
  int? userVerified;
  String? createdAt;
  String? updatedAt;

  ContentsModel(
      {this.id,
      this.uuid,
      this.title,
      this.content,
      this.thumbnail,
      this.categoryId,
      this.category,
      this.sectionId,
      this.link,
      this.tags,
      this.status,
      this.isVideo,
      this.isExternal,
      this.createdBy,
      this.createdByName,
      this.userVerified,
      this.createdAt,
      this.updatedAt,});

  ContentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    categoryId = json['category_id'];
    category = json['category'];
    sectionId = json['section_id'];
    link = json['link'];
    tags = json['tags'];
    status = json['status'];
    isVideo = json['is_video'];
    isExternal = json['is_external'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    userVerified = json['user_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['section_id'] = this.sectionId;
    data['link'] = this.link;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['is_video'] = this.isVideo;
    data['is_external'] = this.isExternal;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    data['user_verified'] = this.userVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
