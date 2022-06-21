import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'detail_article_event.dart';
part 'detail_article_state.dart';

class DetailArticleBloc extends Bloc<DetailArticleEvent, DetailArticleState> {
  DetailArticleBloc() : super(DetailArticleState()) {
    on<DetailArticleEventGetDetail>(_getData);
    on<DetailArticleEventRefresh>(_onRefresh);
    on<DetailArticleEventSetActiveBanner>(_setActiveBanner);
  }
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late YoutubePlayerController ytController;
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
      if (response?.data?.isVideo == 1) {
        ytController = YoutubePlayerController(
          initialVideoId:
              YoutubePlayerController.convertUrlToId(response?.data?.link) ??
                  'cGjueCyKb5g',
          params: const YoutubePlayerParams(
            // startAt: const Duration(minutes: 1, seconds: 36),
            showControls: true,
            showFullscreenButton: true,
            desktopMode: false,
            privacyEnhanced: true,
            useHybridComposition: true,
            showVideoAnnotations: false,
          ),
        );
        ytController.onEnterFullscreen = () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          print('Entered Fullscreen');
        };
        ytController.onExitFullscreen = () {
          print('Exited Fullscreen');
        };
      }
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
