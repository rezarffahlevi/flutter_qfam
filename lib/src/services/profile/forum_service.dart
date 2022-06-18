import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';

class ProfileService {
  ApiHelper apiHelper = ApiHelper();

  ProfileService();

  Future<DefaultResponseModel?> getCurrentUser({dynamic params}) async {
    try {
      var response = await apiHelper.get('/current_user', params: params);
      return DefaultResponseModel.fromJson(response, UserModel.fromJson(response['data']));
    } catch (e) {
      throw e;
    }
  }
}
