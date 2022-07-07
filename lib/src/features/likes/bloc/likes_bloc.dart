import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qfam/src/models/contents/likes_model.dart';
import 'package:flutter_qfam/src/models/contents/notification_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesBloc() : super(const LikesState()) {
    on<LikesEventGetData>(_getData);
    on<LikesEventRefresh>(_onRefresh);
  }
  ContentService apiService = ContentService();

  _onRefresh(LikesEventRefresh event, Emitter<LikesState> emit) async {}

  _getData(LikesEventGetData event, Emitter<LikesState> emit) async {
    try {
      if (event.page < 2) emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getListLike(params: {
        'page': event.page,
      });

      List<LikesModel>? list = [];
      if (event.page > 1) {
        list = state.list;
        list?.addAll(response?.data);
      } else {
        list = response?.data;
      }
      emit(state.copyWith(
          page: event.page,
          resNotif: response,
          state: NetworkStates.onLoaded,
          list: list));
    } catch (e) {
      emit(state.copyWith(
          state: NetworkStates.onError,
          resNotif: DefaultResponseModel(message: e.toString())));
    }
  }
}
