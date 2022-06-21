import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'detail_article_event.dart';
part 'detail_article_state.dart';

class DetailArticleBloc extends Bloc<DetailArticleEvent, DetailArticleState> {
  DetailArticleBloc() : super(DetailArticleState()) {
    on<DetailArticleEventGetDetail>(_getData);
    on<DetailArticleEventRefresh>(_onRefresh);
    on<DetailArticleEventSetActiveBanner>(_setActiveBanner);
  }
  ContentService apiService = ContentService();

  _onRefresh(
      DetailArticleEventRefresh event, Emitter<DetailArticleState> emit) async {
    add(DetailArticleEventGetDetail());
  }

  _getData(DetailArticleEventGetDetail event,
      Emitter<DetailArticleState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getDetailContent({'id': event.uuid});
      emit(state.copyWith(
          state: NetworkStates.onLoaded,
          detail: response?.data,
          bannerList: response?.data?.banner));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _setActiveBanner(DetailArticleEventSetActiveBanner event,
      Emitter<DetailArticleState> emit) async {
    emit(state.copyWith(activeBanner: event.activeBanner));
  }
}
