import 'package:flutter_qfam/src/models/contents/banner_model.dart';

class ContentsModel {
  int? id;
  String? uuid;
  String? title;
  String? subtitle;
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
  String? sourceBy;
  String? verifiedBy;
  int? userVerified;
  String? createdAt;
  String? updatedAt;
  List<FilesModel>? banner;

  ContentsModel({
    this.id,
    this.uuid,
    this.title,
    this.subtitle,
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
    this.sourceBy,
    this.verifiedBy,
    this.userVerified,
    this.createdAt,
    this.updatedAt,
    this.banner,
  });

  ContentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    subtitle = json['subtitle'];
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
    sourceBy = json['source_by'];
    verifiedBy = json['verified_by'];
    userVerified = json['user_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if (json['banner'] != null) {
      banner = <FilesModel>[];
      json['banner']!.forEach((v) {
        banner!.add(new FilesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
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
    data['source_by'] = this.sourceBy;
    data['verified_by'] = this.verifiedBy;
    data['user_verified'] = this.userVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;

    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
