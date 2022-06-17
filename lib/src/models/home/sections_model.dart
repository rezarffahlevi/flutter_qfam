class SectionsModel {
  int? id;
  String? title;
  String? description;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<ContentsModel>? contents;

  SectionsModel(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.contents});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['contents'] != null) {
      contents = <ContentsModel>[];
      json['contents'].forEach((v) {
        contents!.add(new ContentsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentsModel {
  int? id;
  String? uuid;
  String? title;
  String? content;
  String? thumbnail;
  int? categoryId;
  int? sectionId;
  String? link;
  String? tags;
  String? status;
  int? isVideo;
  int? isExternal;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? category;

  ContentsModel(
      {this.id,
      this.uuid,
      this.title,
      this.content,
      this.thumbnail,
      this.categoryId,
      this.sectionId,
      this.link,
      this.tags,
      this.status,
      this.isVideo,
      this.isExternal,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.category});

  ContentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    categoryId = json['category_id'];
    sectionId = json['section_id'];
    link = json['link'];
    tags = json['tags'];
    status = json['status'];
    isVideo = json['is_video'];
    isExternal = json['is_external'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['category_id'] = this.categoryId;
    data['section_id'] = this.sectionId;
    data['link'] = this.link;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['is_video'] = this.isVideo;
    data['is_external'] = this.isExternal;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    return data;
  }
}
