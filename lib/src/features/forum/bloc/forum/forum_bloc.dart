import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/commons/preferences_base.dart';
import 'package:flutter_qfam/src/models/forum/forum_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/services/forum/forum_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';

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
  }
  ForumService apiService = ForumService();
  TabController? tabController;
  final txtContent = TextEditingController();

  _initPostThread(
      ForumEventInitPostThread event, Emitter<ForumState> emit) async {
    try {
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
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getThreadsList({
        'id': event.uuid,
        'parent_id': event.parentId,
        'forum_id': event.forumId,
        'content_id': event.contentId,
      });
      emit(state.copyWith(
        state: NetworkStates.onLoaded,
        threadsList: response?.data,
        uuid: event.uuid,
        parentId: event.parentId,
        forumId: event.forumId,
      ));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _getForumList(ForumEventGetForumList event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getForumList();
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
        'content': state.content
      };
      var response = await apiService.postThread(params);
      emit(state.copyWith(
          state: NetworkStates.onLoaded,
          message: response?.message,
          threads: response?.data));
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
          forumId: event.forumId));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }
}
