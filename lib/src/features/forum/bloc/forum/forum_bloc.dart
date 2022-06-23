import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/commons/preferences_base.dart';
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
    on<ForumEventRefresh>(_onRefresh);
    on<ForumEventPostThread>(_postThread);
    on<ForumEventOnChangeThread>(_onChangeThread);
    on<ForumEventInit>(_onInit);

    _didMount();
  }
  ForumService apiService = ForumService();
  final txtContent = TextEditingController();

  _didMount() {
    txtContent.addListener(() {
      add(ForumEventOnChangeThread(content: txtContent.text));
    });
  }

  _onRefresh(ForumEventRefresh event, Emitter<ForumState> emit) async {
    add(ForumEventGetData());
  }

  _getData(ForumEventGetData event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getList({'id': event.uuid});
      // debugPrint('forum ${await Prefs.token}');
      emit(state.copyWith(
          state: NetworkStates.onLoaded, threadsList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _postThread(ForumEventPostThread event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var params = {'parent_id': state.parentId, 'content': state.content};
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
      emit(state.copyWith(parentId: event.parentId, content: event.content));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onInit(ForumEventInit event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(context: event.context));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }
}
