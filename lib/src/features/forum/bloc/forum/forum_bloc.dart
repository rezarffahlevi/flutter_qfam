import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/services/forum/forum_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'forum_event.dart';
part 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumBloc() : super(const ForumState()) {
    on<ForumEventGetData>(_getData);
    on<ForumEventRefresh>(_onRefresh);

    // add(ForumEventGetData());
  }
  ForumService apiService = ForumService();

  _onRefresh(ForumEventRefresh event, Emitter<ForumState> emit) async {
    add(ForumEventGetData());
  }

  _getData(ForumEventGetData event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getList({'id': event.uuid});
      debugPrint(response?.data!.length.toString());
      emit(state.copyWith(
          state: NetworkStates.onLoaded, threads: response?.data));
    } catch (e) {
      debugPrint('catch ${e}');
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }
}
