class ForumModel {
  int? id;
  String? uuid;
  String? name;
  String? title;
  String? description;
  String? icon;
  String? createdAt;
  String? updatedAt;

  ForumModel(
      {this.id,
      this.uuid,
      this.name,
      this.title,
      this.description,
      this.icon,
      this.createdAt,
      this.updatedAt});

  ForumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['_id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.uuid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
