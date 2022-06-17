import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/home/sections_model.dart';
import 'package:flutter_qfam/src/models/home/home_model.dart';
import 'package:flutter_qfam/src/models/home/product_model.dart';
import 'package:flutter/material.dart';

class HomeService {
  ApiHelper apiHelper = ApiHelper();

  HomeService();

  Future<DefaultResponseModel?> getHomeData() async {
    try {
      var response = await apiHelper.get('/dummy/home.json');
      // var homeModel = HomeModel.fromJson(response['data']);
      List<Category>? category = <Category>[];
      // List<Home>? home = <Home>[];
      // if (homeModel.category != null) {
      //   homeModel.category!
      //       .map((v) => category.add(Category.fromJson(v.toJson())))
      //       .toList();
      // }
      // if (homeModel.home != null) {
      //   homeModel.home!
      //       .map((v) => home.add(Home.fromJson(v.toJson())))
      //       .toList();
      // }
      // homeModel.category = category;
      // homeModel.home = home;
      // return DefaultResponseModel.fromJson(response, homeModel);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getNewFashion() async {
    try {
      var response =
          await apiHelper.get('/f7b172cf-eb64-471b-b2d3-2876e00805a8');
      List<ProductModel>? data = <ProductModel>[];
      if (response['data'] != null) {
        response['data']!
            .map((v) => data.add(ProductModel.fromJson(v)))
            .toList();
      }
      // return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DefaultResponseModel?> getHotSales() async {
    try {
      var response =
          await apiHelper.get('/244dc8ee-0dde-4e42-91c3-bc6f36995959');
      List<ProductModel>? data = <ProductModel>[];
      if (response['data'] != null) {
        response['data']!
            .map((v) => data.add(ProductModel.fromJson(v)))
            .toList();
      }
      // return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
