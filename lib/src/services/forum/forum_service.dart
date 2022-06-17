import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/models/home/sections_model.dart';
import 'package:flutter_qfam/src/models/home/home_model.dart';
import 'package:flutter_qfam/src/models/home/product_model.dart';
import 'package:flutter/material.dart';

class ForumService {
  ApiHelper apiHelper = ApiHelper();

  ForumService();

  Future<DefaultResponseModel?> getList(dynamic params) async {
    try {
      var response = await apiHelper.get('/threads', params: params);
      List<ThreadsModel>? data = <ThreadsModel>[];
      response['data']!.forEach((v) {
        data.add(new ThreadsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> postThread(dynamic params) async {
    try {
      var response = await apiHelper.post('/threads/save', params: params);
      return DefaultResponseModel.fromJson(response, null);
    } catch (e) {
      throw e;
    }
  }
}