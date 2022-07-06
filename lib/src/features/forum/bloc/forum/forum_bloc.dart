import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_qfam/src/commons/preferences_base.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/models/forum/forum_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/services/forum/forum_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'forum_event.dart';

part 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumBloc() : super(const ForumState()) {
    on<ForumEventGetData>(_getData);
    on<ForumEventGetForumList>(_getForumList);
    on<ForumEventRefresh>(_onRefresh);
    on<ForumEventPostThread>(_postThread);
    on<ForumEventOnChangeThread>(_onChangeThread);
    on<ForumEventInitPostThread>(_initPostThread);
    on<ForumEventInitForumList>(_initForumList);
    on<ForumEventOnLiked>(_toggleLike);
    on<ForumEventAddPhoto>(_addPhoto);
  }

  ForumService apiService = ForumService();
  ContentService contentService = ContentService();
  TabController? tabController;
  List<RefreshController> refreshController = [
    RefreshController(initialRefresh: false)
  ];
  final txtContent = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  _initPostThread(
      ForumEventInitPostThread event, Emitter<ForumState> emit) async {
    try {
      add(ForumEventOnChangeThread(isAnonymous: 0));
      txtContent.addListener(() {
        add(ForumEventOnChangeThread(content: txtContent.text));
      });
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _initForumList(
      ForumEventInitForumList event, Emitter<ForumState> emit) async {
    tabController?.addListener(() {
      var forumId = state.forumList![tabController!.index].id;
      add(ForumEventGetData(forumId: forumId));
      add(ForumEventOnChangeThread(forumId: forumId));
    });
  }

  _onRefresh(ForumEventRefresh event, Emitter<ForumState> emit) async {
    add(ForumEventGetForumList());
    add(ForumEventGetData(
        forumId: state.forumId, parentId: state.parentId, uuid: state.uuid));
  }

  _getData(ForumEventGetData event, Emitter<ForumState> emit) async {
    try {
      if (event.page < 2) emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getThreadsList({
        'uuid': event.uuid,
        'id': event.id,
        'parent_id': event.parentId,
        'forum_id': event.forumId,
        'content_id': event.contentId,
        'page': event.page,
      });
      List<ThreadsModel>? threadsList = [];
      if (event.page > 1) {
        threadsList = state.threadsList;
        threadsList?.addAll(response?.data);
      } else {
        threadsList = response?.data;
      }
      emit(state.copyWith(
        state: NetworkStates.onLoaded,
        threadsList: threadsList,
        uuid: event.uuid,
        parentId: event.parentId,
        forumId: event.forumId,
        contentId: event.contentId,
        page: event.page,
        response: response,
        thread: response?.detail 
      ));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _getForumList(ForumEventGetForumList event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getForumList();
      response?.data!.forEach((item) {
        refreshController.add(RefreshController(initialRefresh: false));
      });
      emit(state.copyWith(
          state: NetworkStates.onLoaded, forumList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _postThread(ForumEventPostThread event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var params = {
        'forum_id': state.forumId,
        'parent_id': state.parentId,
        'content': state.content,
        'content_id': state.contentId,
        'is_anonymous': state.isAnonymous,
      };
      var response = await apiService.postThread(params);
      if (!Helpers.isEmpty(state.photo?.path)) {
        await _uploadFile(response?.data);
      }
      emit(state.copyWith(
        state: NetworkStates.onLoaded,
        message: response?.message,
      ));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _uploadFile(ThreadsModel? data) async {
    try {
      FilesModel files = FilesModel();
      files.file = File(
        state.photo!.path,
      );
      files.parentId = data?.uuid;
      var response = await contentService.uploadFile(files);
      debugPrint('file data ${response?.data?.id}');
    } catch (e) {
      debugPrint('ERROR FILE ${e}');
    }
  }

  _toggleLike(ForumEventOnLiked event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading, message: 'like'));
      var response =
          await apiService.likeThread({"thread_id": event.thread_id});
      if (event.isParent) {
        var detail = state.thread;
        var isLike = detail?.isLiked == 1;
        detail?.isLiked = isLike ? 0 : 1;
        detail?.countLikes = isLike
            ? (detail.countLikes ?? 1) - 1
            : (detail.countLikes ?? 0) + 1;
        emit(state.copyWith(
            thread: detail,
            state: NetworkStates.onLoaded,
            message: 'success'));
      } else {
        int index = state.threadsList
                ?.indexWhere((element) => element.id == event.thread_id) ??
            0;
        List<ThreadsModel>? threadsList = state.threadsList;
        var isLike = threadsList![index].isLiked == 1;
        threadsList[index].isLiked = isLike ? 0 : 1;
        threadsList[index].countLikes = isLike
            ? (threadsList[index].countLikes ?? 1) - 1
            : (threadsList[index].countLikes ?? 0) + 1;
        emit(state.copyWith(
            threadsList: threadsList,
            state: NetworkStates.onLoaded,
            message: 'success'));
      }
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onChangeThread(
      ForumEventOnChangeThread event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(
          parentId: event.parentId,
          content: event.content,
          forumId: event.forumId,
          contentId: event.contentId,
          isAnonymous: event.isAnonymous));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _addPhoto(ForumEventAddPhoto event, Emitter<ForumState> emit) async {
    try {
      // Pick an image
      emit(state.copyWith(state: NetworkStates.onLoading));
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 25);
      emit(state.copyWith(photo: image, state: NetworkStates.onLoaded));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }
}
