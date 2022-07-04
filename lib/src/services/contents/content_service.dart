import 'dart:io';

import 'package:dio/dio.dart';
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

  Future<DefaultResponseModel?> getList({dynamic params}) async {
    try {
      var response = await apiHelper.get('/contents', params: params);
      List<ContentsModel>? data = <ContentsModel>[];
      response['data']!.forEach((v) {
        data.add(new ContentsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> postArticle({dynamic params}) async {
    try {
      var response = await apiHelper.post('/contents/save', params: params);
      ContentsModel? data = ContentsModel.fromJson(response['data']);
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

  Future<DefaultResponseModel?> uploadFile(FilesModel params) async {
    try {
      String fileName = params.file!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(params.file!.path, filename: fileName),
        "parent_id": params.parentId
      });
      var response = await apiHelper.post(
        '/contents/save_file',
        params: formData,
      );
      return DefaultResponseModel.fromJson(
          response, FilesModel.fromJson(response['data']));
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> uploadThumbnail(FilesModel params) async {
    try {
      String fileName = params.file!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "thumbnail":
            await MultipartFile.fromFile(params.file!.path, filename: fileName),
        "id": params.id
      });
      var response = await apiHelper.post(
        '/contents/save_thumbnail',
        params: formData,
      );
      return DefaultResponseModel.fromJson(
          response, ContentsModel.fromJson(response['data']));
    } catch (e) {
      throw e;
    }
  }
}
