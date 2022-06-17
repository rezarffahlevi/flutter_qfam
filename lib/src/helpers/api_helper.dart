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
    options.headers = {
      'Authorization':
          'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjU1MzYyMDY4LCJleHAiOjE2NTc5OTAwNjgsIm5iZiI6MTY1NTM2MjA2OCwianRpIjoia3lwNUZhdE92VGpmMFN4MiIsInN1YiI6IjEiLCJwcnYiOiJmNjRkNDhhNmNlYzdiZGZhN2ZiZjg5OTQ1NGI0ODhiM2U0NjI1MjBhIn0.YvNGAWhEjxhN1sumUAmH0X9EMcFTo7CrR6psVco06S4'
    };
    dio.options = options;

    try {
      var response = await dio.get(url, queryParameters: params);
      debugPrint("======== GET API ${url} <> params: ${params} ========");
      if (response.data['code'] != '00') {
        debugPrint('API ERROR CODE: ${response.data['code']} :: ${response.data['error']}');
      }
      return json.decode(response.toString());
    } on DioError catch (e) {
      debugPrint("======== ERROR GET API ${url} : ${e.message} ========");
      throw e.error;
    }
  }

  Future<dynamic> post(String url, {dynamic params, String? baseUrl}) async {
    baseUrl = baseUrl ?? BASE_URL;
    options.baseUrl = baseUrl;
    options.headers = {
      'Authorization':
          'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjU1MzYyMDY4LCJleHAiOjE2NTc5OTAwNjgsIm5iZiI6MTY1NTM2MjA2OCwianRpIjoia3lwNUZhdE92VGpmMFN4MiIsInN1YiI6IjEiLCJwcnYiOiJmNjRkNDhhNmNlYzdiZGZhN2ZiZjg5OTQ1NGI0ODhiM2U0NjI1MjBhIn0.YvNGAWhEjxhN1sumUAmH0X9EMcFTo7CrR6psVco06S4'
    };
    dio.options = options;

    try {
      var response = await dio.post(url, data: params);
      debugPrint("======== POST API ${url} <> params: ${params} ========\n");
      if (response.data['code'] != '00') {
        debugPrint('API ERROR CODE: ${response.data['code']} :: ${response.data['error']}');
      }
      return json.decode(response.toString());
    } on DioError catch (e) {
      debugPrint(
          "======== ERROR POST API ${url} : ${e.message} ========\n PARAMS: ${params}\n HEADERS: ${params}");
      throw e.error;
    }
  }
}
