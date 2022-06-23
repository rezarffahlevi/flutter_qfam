import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';

class AuthService {
  ApiHelper apiHelper = ApiHelper();

  AuthService();

  Future<DefaultResponseModel?> getCurrentUser({dynamic params}) async {
    try {
      var response = await apiHelper.get('/current_user', params: params);
      return DefaultResponseModel.fromJson(
          response, UserModel.fromJson(response['data']));
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> onLogin({dynamic params}) async {
    try {
      var response = await apiHelper.post('/login', params: params);
      ResponseLoginModel? data;
      if (response['data'] != null)
        data = ResponseLoginModel.fromJson(response['data']);
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> onRegister({dynamic params}) async {
    try {
      var response = await apiHelper.post('/register', params: params);
      ResponseLoginModel? data;
      if (response['data'] != null)
        data = ResponseLoginModel.fromJson(response['data']);
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> onLogout({dynamic params}) async {
    try {
      var response = await apiHelper.post('/logout', params: params);
      ResponseLoginModel? data;
      if (response['data'] != null)
        data = ResponseLoginModel.fromJson(response['data']);
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }
}
