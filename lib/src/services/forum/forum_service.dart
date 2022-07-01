import 'package:flutter_qfam/src/helpers/api_helper.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/forum/forum_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
class ForumService {
  ApiHelper apiHelper = ApiHelper();

  ForumService();


  Future<DefaultResponseModel?> getForumList() async {
    try {
      var response = await apiHelper.get('/forum');
      List<ForumModel>? data = <ForumModel>[];
      response['data']!.forEach((v) {
        data.add(new ForumModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> getThreadsList(dynamic params) async {
    try {
      var response = await apiHelper.get('/threads', params: params);
      List<ThreadsModel>? data = <ThreadsModel>[];
      response['data']!.forEach((v) {
        data.add(new ThreadsModel.fromJson(v));
      });
      return DefaultResponseModel.fromJson(response, data);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> postThread(dynamic params) async {
    try {
      var response = await apiHelper.post('/threads/save', params: params);
      return DefaultResponseModel.fromJson(response, null);
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultResponseModel?> likeThread(dynamic params) async {
    try {
      var response = await apiHelper.post('/like', params: params);
      return DefaultResponseModel.fromJson(response, null);
    } catch (e) {
      throw e;
    }
  }
}
