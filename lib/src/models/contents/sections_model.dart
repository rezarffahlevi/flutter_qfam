import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/contents/program_model.dart';

class SectionsModel {
  int? id;
  String? title;
  String? description;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? contents;

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
      if (title!.contains("Program Kami")) {
        contents = <ProgramModel>[];
        json['contents'].forEach((v) {
          contents!.add(new ProgramModel.fromJson(v));
        });
      } else {
        contents = <ContentsModel>[];
        json['contents'].forEach((v) {
          contents!.add(new ContentsModel.fromJson(v));
        });
      }
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
