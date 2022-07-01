import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/commons/app_settings.dart';
import 'package:flutter_qfam/src/commons/preferences_base.dart';

class ApiHelper {
  ConfigModel config = getConfig();

  static ConfigModel getConfig() {
    return AppSettings.getConfig;
  }

  BaseOptions options = BaseOptions(
    // baseUrl: config.BASE_URL,
    connectTimeout: 10000,
    receiveTimeout: 5000,
  );
  Dio dio = new Dio();

  _getHeaders() async {
    // debugPrint('header ${await Prefs.token}');
    return {
      'Authorization': await Prefs.token,
    };
  }

  Future<dynamic> get(String url, {dynamic params, String? baseUrl}) async {
    baseUrl = baseUrl ?? config.BASE_URL;
    options.baseUrl = baseUrl;
    options.headers = await _getHeaders();
    dio.options = options;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      var response = await dio.get(url, queryParameters: params);
      debugPrint("======== GET API ${url} <> params: ${params} ========");
      if (response.data['code'] != '00') {
        debugPrint(
            'API ERROR CODE: ${response.data['code']} :: ${response.data['error']}');
      }
      return json.decode(response.toString());
    } on DioError catch (e) {
      debugPrint(
          "======== ERROR GET API ${url} : ${e.message} ========\n PARAMS: ${params}\n HEADERS: ${options.headers}  \n===================================================");
      throw e.error;
    }
  }

  Future<dynamic> post(String url, {dynamic params, String? baseUrl}) async {
    baseUrl = baseUrl ?? config.BASE_URL;
    options.baseUrl = baseUrl;
    options.headers = await _getHeaders();
    dio.options = options;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      var response = await dio.post(url, data: params);
      debugPrint("======== POST API ${url} <> params: ${params} ========\n");
      if (response.data['code'] != '00') {
        debugPrint(
            'API ERROR CODE: ${response.data['code']} - ${response.data['message']} :: ${response.data['error']}');
      }
      // debugPrint('HEADERS: ${options.headers}');
      return json.decode(response.toString());
    } on DioError catch (e) {
      debugPrint(
          "======== ERROR POST API ${url} : ${e.message} ========\n PARAMS: ${params}\n HEADERS: ${options.headers}  \n===================================================");
      throw e.error;
    }
  }
}
