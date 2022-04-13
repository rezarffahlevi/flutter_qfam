import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  static const String BASE_URL = 'https://reza.onepeerstech.com';

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
      debugPrint(e.toString());
      throw Exception(e.error);
    }
  }
}
