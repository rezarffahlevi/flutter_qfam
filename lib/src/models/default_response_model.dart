import 'package:flutter_siap_nikah/src/models/home/category_model.dart';

class DefaultResponseModel {
  String? code;
  String? message;
  dynamic error;
  dynamic data;

  DefaultResponseModel({this.code, this.message, this.error, this.data});

  DefaultResponseModel.fromJson(Map<String, dynamic> json, dynamic jsonData) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    data = jsonData != null ? jsonData : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
