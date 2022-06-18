class UserModel {
  int? id;
  String? uuid;
  String? name;
  String? gender;
  String? religion;
  String? role;
  String? email;
  int? isActive;
  int? isVerified;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.uuid,
      this.name,
      this.gender,
      this.religion,
      this.role,
      this.email,
      this.isActive,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    gender = json['gender'];
    religion = json['religion'];
    role = json['role'];
    email = json['email'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['role'] = this.role;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
