class FilesModel {
  int? id;
  String? name;
  String? path;
  String? type;
  String? link;
  String? note;
  String? from;
  String? parentId;
  String? createdAt;
  String? updatedAt;

  FilesModel(
      {this.id,
      this.name,
      this.path,
      this.type,
      this.link,
      this.note,
      // this.from,
      this.parentId,
      this.createdAt,
      this.updatedAt});

  FilesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    type = json['type'];
    link = json['link'];
    note = json['note'];
    from = json['from'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['path'] = this.path;
    data['type'] = this.type;
    data['link'] = this.link;
    data['note'] = this.note;
    data['from'] = this.from;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
