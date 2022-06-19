import 'package:flutter/material.dart';

enum AppEnv { PRODUCTION, STAGING, DEVELOPMENT }

class ConfigModel {
  AppEnv? ENV;
  String BASE_URL = '';
}

class AppSettings {
  static String name = 'Quality Family';

  // CHANGE THIS ENV
  static AppEnv ENV = AppEnv.STAGING;

  AppSettings() {}

  static ConfigModel get getConfig {
    var config = new ConfigModel();

    switch (ENV) {
      case AppEnv.DEVELOPMENT:
        config.ENV = AppEnv.DEVELOPMENT;
        config.BASE_URL = 'http://192.168.0.109:8000/api';
        break;
      case AppEnv.STAGING:
        config.ENV = AppEnv.STAGING;
        config.BASE_URL = 'https://qfam.onepeerstech.com/api';
        break;
      default:
        config.ENV = AppEnv.PRODUCTION;
        config.BASE_URL = 'https://qfam.onepeerstech.com/api';
        break;
    }
    return config;
  }
}
