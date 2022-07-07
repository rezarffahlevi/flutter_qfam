class NotificationModel {
  int? id;
  String? title;
  String? description;
  int? from;
  int? forId;
  String? action;
  String? navigationTo;
  NotificationInfoModel? info;
  String? createdAt;
  String? updatedAt;
  String? uuid;
  String? name;
  String? telp;
  String? gender;
  String? religion;
  String? role;
  String? photo;
  String? email;
  String? fcmToken;
  int? isActive;
  int? isVerified;

  NotificationModel(
      {this.id,
      this.title,
      this.description,
      this.from,
      this.forId,
      this.action,
      this.navigationTo,
      this.info,
      this.createdAt,
      this.updatedAt,
      this.uuid,
      this.name,
      this.telp,
      this.gender,
      this.religion,
      this.role,
      this.photo,
      this.email,
      this.fcmToken,
      this.isActive,
      this.isVerified});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    from = json['from'];
    forId = json['for'];
    action = json['action'];
    navigationTo = json['navigation_to'];
    info = json['info'] != null
        ? new NotificationInfoModel.fromJson(json['info'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    uuid = json['uuid'];
    name = json['name'];
    telp = json['telp'];
    gender = json['gender'];
    religion = json['religion'];
    role = json['role'];
    photo = json['photo'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['from'] = this.from;
    data['for'] = this.forId;
    data['action'] = this.action;
    data['navigation_to'] = this.navigationTo;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['telp'] = this.telp;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['role'] = this.role;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    return data;
  }
}

class NotificationInfoModel {
  int? id;
  String? uuid;
  String? content;
  int? forumId;
  int? createdBy;
  int? isAnonymous;
  int? contentId;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? telp;
  String? gender;
  String? religion;
  String? role;
  String? photo;
  String? email;
  String? fcmToken;
  int? isActive;
  int? isVerified;

  NotificationInfoModel(
      {this.id,
      this.uuid,
      this.content,
      this.forumId,
      this.createdBy,
      this.isAnonymous,
      this.contentId,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.telp,
      this.gender,
      this.religion,
      this.role,
      this.photo,
      this.email,
      this.fcmToken,
      this.isActive,
      this.isVerified});

  NotificationInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    content = json['content'];
    forumId = json['forum_id'];
    createdBy = json['created_by'];
    isAnonymous = json['is_anonymous'];
    contentId = json['content_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    telp = json['telp'];
    gender = json['gender'];
    religion = json['religion'];
    role = json['role'];
    photo = json['photo'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['content'] = this.content;
    data['forum_id'] = this.forumId;
    data['created_by'] = this.createdBy;
    data['is_anonymous'] = this.isAnonymous;
    data['content_id'] = this.contentId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    data['telp'] = this.telp;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['role'] = this.role;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
