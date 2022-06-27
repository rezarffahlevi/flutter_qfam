class UserModel {
  int? id;
  String? uuid;
  String? name;
  String? telp;
  String? photo;
  String? gender;
  String? religion;
  String? role;
  String? email;
  String? password;
  int? isActive;
  int? isVerified;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.uuid,
      this.name,
      this.telp,
      this.photo,
      this.gender,
      this.religion,
      this.role,
      this.email,
      this.password,
      this.isActive,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['_id'];
    name = json['name'];
    telp = json['telp'];
    photo = json['photo'];
    gender = json['gender'];
    religion = json['religion'];
    role = json['role'];
    email = json['email'];
    password = json['password'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.uuid;
    data['name'] = this.name;
    data['telp'] = this.telp;
    data['photo'] = this.photo;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['role'] = this.role;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ResponseLoginModel {
  String? token;
  UserModel? user;
  String? tokenType;

  ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token_type'] = this.tokenType;
    return data;
  }
}
