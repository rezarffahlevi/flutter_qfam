import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/category_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'detail_article_event.dart';
part 'detail_article_state.dart';

class DetailArticleBloc extends Bloc<DetailArticleEvent, DetailArticleState> {
  DetailArticleBloc() : super(DetailArticleState()) {
    on<DetailArticleEventGetDetail>(_getData);
    on<DetailArticleEventInitPost>(_initPostArticle);
    on<DetailArticleEventOnPost>(_onPostArticle);
    on<DetailArticleEventRefresh>(_onRefresh);
    on<DetailArticleEventSetActiveBanner>(_setActiveBanner);
    on<DetailArticleEventOnChange>(_onChangeFormdata);
    on<DetailArticleEventGetCategory>(_getCategory);
  }
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late YoutubePlayerController ytController;
  ContentService apiService = ContentService();

  final txtTitle = TextEditingController();
  final txtSubtitle = TextEditingController();
  final txtLink = TextEditingController();
  final txtContent = TextEditingController();
  final txtThumbnail = TextEditingController();
  final txtSourceBy = TextEditingController();
  final txtVerifiedBy = TextEditingController();

  _initPostArticle(DetailArticleEventInitPost event,
      Emitter<DetailArticleState> emit) async {
    add(DetailArticleEventGetCategory());
    add(DetailArticleEventOnChange(
        categoryId: 1, isExternal: 0, isVideo: 0, status: 'publish'));
    txtTitle.addListener(() {
      add(DetailArticleEventOnChange(title: txtTitle.text));
    });
    txtSubtitle.addListener(() {
      add(DetailArticleEventOnChange(subtitle: txtSubtitle.text));
    });
    txtLink.addListener(() {
      add(DetailArticleEventOnChange(link: txtLink.text));
    });
    txtContent.addListener(() {
      add(DetailArticleEventOnChange(content: txtContent.text));
    });
    txtThumbnail.addListener(() {
      add(DetailArticleEventOnChange(thumbnail: txtThumbnail.text));
    });
    txtSourceBy.addListener(() {
      add(DetailArticleEventOnChange(sourceBy: txtSourceBy.text));
    });
    txtVerifiedBy.addListener(() {
      add(DetailArticleEventOnChange(verifiedBy: txtVerifiedBy.text));
    });
  }

  _onPostArticle(
      DetailArticleEventOnPost event, Emitter<DetailArticleState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response =
          await apiService.postArticle(params: state.formdata!.toJson());
      emit(state.copyWith(
        state: NetworkStates.onLoaded,
        detail: response?.data,
        bannerList: response?.data?.banner,
        message: response?.message,
      ));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onRefresh(DetailArticleEventRefresh event,
      Emitter<DetailArticleState> emit) async {}

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

  _onChangeFormdata(DetailArticleEventOnChange event,
      Emitter<DetailArticleState> emit) async {
    emit(state.copyWith(state: NetworkStates.onLoading));
    ContentsModel? formdata = ContentsModel(
      id: state.formdata?.id,
      title: state.formdata?.title,
      subtitle: state.formdata?.subtitle,
      categoryId: state.formdata?.categoryId,
      isExternal: state.formdata?.isExternal,
      isVideo: state.formdata?.isVideo,
      link: state.formdata?.link,
      content: state.formdata?.content,
      thumbnail: state.formdata?.thumbnail,
      status: state.formdata?.status,
      sourceBy: state.formdata?.sourceBy,
      verifiedBy: state.formdata?.verifiedBy,
    );
    if (event.id != null) formdata.id = event.id;
    if (event.title != null) formdata.title = event.title;
    if (event.subtitle != null) formdata.subtitle = event.subtitle;
    if (event.categoryId != null) formdata.categoryId = event.categoryId;
    if (event.isExternal != null) formdata.isExternal = event.isExternal;
    if (event.isVideo != null) formdata.isVideo = event.isVideo;
    if (event.link != null) formdata.link = event.link;
    if (event.content != null) formdata.content = event.content;
    if (event.thumbnail != null) formdata.thumbnail = event.thumbnail;
    if (event.sourceBy != null) formdata.sourceBy = event.sourceBy;
    if (event.verifiedBy != null) formdata.verifiedBy = event.verifiedBy;
    if (event.status != null) formdata.status = event.status;

    emit(state.copyWith(formdata: formdata, state: NetworkStates.onLoaded));
  }

  _getCategory(DetailArticleEventGetCategory event,
      Emitter<DetailArticleState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getCategoryList();
      emit(state.copyWith(
          state: NetworkStates.onLoaded, categoryList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: e.toString()));
    }
  }

  _setActiveBanner(DetailArticleEventSetActiveBanner event,
      Emitter<DetailArticleState> emit) async {
    emit(state.copyWith(activeBanner: event.activeBanner));
  }
}
