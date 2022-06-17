class ThreadsModel {
  int? id;
  String? uuid;
  String? content;
  int? forumId;
  int? createdBy;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? gender;
  String? religion;
  String? role;
  String? email;
  int? isActive;
  int? isVerified;
  int? userId;
  List<ThreadsModel>? child;

  ThreadsModel(
      {this.id,
      this.uuid,
      this.content,
      this.forumId,
      this.createdBy,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.gender,
      this.religion,
      this.role,
      this.email,
      this.isActive,
      this.isVerified,
      this.userId,
      this.child});

  ThreadsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    content = json['content'];
    forumId = json['forum_id'];
    createdBy = json['created_by'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    gender = json['gender'];
    religion = json['religion'];
    role = json['role'];
    email = json['email'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    userId = json['user_id'];
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
    data['created_by'] = this.createdBy;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['role'] = this.role;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['user_id'] = this.userId;
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
