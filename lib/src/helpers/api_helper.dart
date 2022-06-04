import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/commons/app_settings.dart';

class ApiHelper {
  static const String BASE_URL = AppSettings.BASE_URL;

  BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio();

  Future<dynamic> get(String url, {dynamic params, String? baseUrl}) async {
    baseUrl = baseUrl ?? BASE_URL;
    options.baseUrl = baseUrl;
    dio.options = options;

    try {
      var response = await dio.get(url, queryParameters: params);
      return json.decode(response.toString());
    } on DioError catch (e) {
      debugPrint("======== ERROR API ${url} : ${e.message} ========");
      throw e.error;
    }
  }
}
