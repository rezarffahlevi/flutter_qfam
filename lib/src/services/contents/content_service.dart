import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/home/sections_model.dart';
import 'package:flutter_qfam/src/models/home/home_model.dart';
import 'package:flutter_qfam/src/models/home/product_model.dart';
import 'package:flutter/material.dart';

class ContentService {
  ApiHelper apiHelper = ApiHelper();

  ContentService();

  Future<DefaultResponseModel?> getList() async {
    try {
      var response = await apiHelper.get('/contents');
      List<SectionsModel>? data = <SectionsModel>[];
      response['data']!.forEach((v) {
        data.add(new SectionsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }
}
