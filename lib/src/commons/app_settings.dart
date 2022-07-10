enum AppEnv { PRODUCTION, STAGING, DEVELOPMENT }

class ConfigModel {
  AppEnv? ENV;
  String BASE_URL = '';
}

class AppSettings {
  static String name = 'Quality Family';

  // CHANGE THIS ENV
  static AppEnv ENV = AppEnv.PRODUCTION;

  AppSettings() {}

  static ConfigModel get getConfig {
    var config = new ConfigModel();

    switch (ENV) {
      case AppEnv.DEVELOPMENT:
        config.ENV = AppEnv.DEVELOPMENT;
        config.BASE_URL = 'http://192.168.1.110:8000/';
        break;
      case AppEnv.STAGING:
        config.ENV = AppEnv.STAGING;
        config.BASE_URL = 'https://qfam.onepeerstech.com/';
        break;
      default:
        config.ENV = AppEnv.PRODUCTION;
        config.BASE_URL = 'https://qfam.onepeerstech.com/';
        break;
    }
    return config;
  }
}
