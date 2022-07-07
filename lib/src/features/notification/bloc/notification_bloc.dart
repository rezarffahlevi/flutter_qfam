import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qfam/src/models/contents/notification_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationEventGetData>(_getData);
    on<NotificationEventRefresh>(_onRefresh);
  }
  ContentService apiService = ContentService();

  _onRefresh(
      NotificationEventRefresh event, Emitter<NotificationState> emit) async {}

  _getData(
      NotificationEventGetData event, Emitter<NotificationState> emit) async {
    try {
      if (event.page < 2) emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getNotifList(params: {
        'page': event.page,
      });

      List<NotificationModel>? list = [];
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
