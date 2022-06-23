import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/category_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/contents/sections_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';

class ContentService {
  ApiHelper apiHelper = ApiHelper();

  ContentService();

  Future<DefaultResponseModel?> getList() async {
    try {
      var response = await apiHelper.get('/contents');
      List<ContentsModel>? data = <ContentsModel>[];
      response['data']!.forEach((v) {
        data.add(new ContentsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getDetailContent(dynamic params) async {
    try {
      var response = await apiHelper.get('/contents', params: params);
      ContentsModel? data = ContentsModel.fromJson(response['data']);
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getHomeList() async {
    try {
      var response = await apiHelper.get('/home');
      List<SectionsModel>? data = <SectionsModel>[];
      response['data']!.forEach((v) {
        data.add(new SectionsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getBannerList() async {
    try {
      var response = await apiHelper.get('/banner');
      List<FilesModel>? data = <FilesModel>[];
      response['data']!.forEach((v) {
        data.add(new FilesModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getCategoryList() async {
    try {
      var response = await apiHelper.get('/category');
      List<CategoryModel>? data = <CategoryModel>[];
      CategoryModel category = new CategoryModel();
      response['data']!.forEach((v) {
        data.add(new CategoryModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }
}
