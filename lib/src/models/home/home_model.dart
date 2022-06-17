import 'package:flutter_qfam/src/models/home/sections_model.dart';

class HomeModel {
  List<Category>? category;
  List<SectionsModel>? sections;

  HomeModel({this.category, this.sections});

  HomeModel.fromJson(String object, List<dynamic>? json) {
    sections = <SectionsModel>[];
    if (object == 'sections') {
      json!.forEach((v) {
        sections!.add(new SectionsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sections != null) {
      data['home'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
