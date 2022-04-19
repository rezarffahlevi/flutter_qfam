import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/services/home/home_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/widgets/widgets.dart';

part 'forum_event.dart';
part 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumBloc() : super(const ForumState()) {
    on<ForumEventGetData>(_getData);
    on<ForumEventRefresh>(_onRefresh);
  }
  HomeService homeService = HomeService();

  _onRefresh(ForumEventRefresh event, Emitter<ForumState> emit) async {
    add(ForumEventGetData());
  }

  _getData(ForumEventGetData event, Emitter<ForumState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      emit(state.copyWith(
          state: NetworkStates.onLoaded));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(state: NetworkStates.onError));
    }
  }
}
