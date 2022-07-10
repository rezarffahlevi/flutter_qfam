import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/category_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:flutter_qfam/src/services/forum/forum_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
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
    on<DetailArticleAddPhoto>(_addPhoto);
    on<DetailArticleOnLiked>(_toggleLike);
    on<DetailArticleEventWebviewHeight>(_setWebviewHeight);
  }
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late YoutubePlayerController ytController;
  ContentService apiService = ContentService();
  ForumService forumService = ForumService();
  final ImagePicker _picker = ImagePicker();

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

    if (event.formdata?.id == null) {
      add(DetailArticleEventOnChange(
          categoryId: 1, isExternal: 0, isVideo: 0, status: 'publish'));
    } else {
      emit(state.copyWith(formdata: event.formdata));
    }
  }

  _onPostArticle(
      DetailArticleEventOnPost event, Emitter<DetailArticleState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      // Validation
      if (Helpers.isEmpty(state.formdata?.title)) {
        return emit(state.copyWith(
            state: NetworkStates.onLoaded,
            response: DefaultResponseModel(code: '01'),
            message: 'Judul wajib di isi'));
      }
      if (state.formdata?.isVideo == 1 &&
          Helpers.isEmpty(state.formdata?.link)) {
        return emit(state.copyWith(
            state: NetworkStates.onLoaded,
            response: DefaultResponseModel(code: '01'),
            message: 'Link wajib di isi'));
      }
      if (state.formdata?.isExternal == 0 &&
          Helpers.isEmpty(state.formdata?.content)) {
        return emit(state.copyWith(
            state: NetworkStates.onLoaded,
            response: DefaultResponseModel(code: '01'),
            message: 'Konten wajib di isi'));
      }

      var response =
          await apiService.postArticle(params: state.formdata!.toJson());
      if (!Helpers.isEmpty(state.thumbnail?.path)) {
        _uploadThumbnail(response?.data);
      }
      if ((state.banner?.length ?? 0) > 0) {
        _uploadFile(response?.data);
      }
      emit(state.copyWith(
          state: NetworkStates.onLoaded,
          detail: response?.data,
          bannerList: response?.data?.banner,
          message: response?.message,
          response: response));
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

      FilesModel banner = new FilesModel();
      banner.link = response?.data?.thumbnail;
      List<FilesModel> bannerList = response?.data?.banner;
      bannerList.insert(0, banner);
      emit(state.copyWith(
          state: NetworkStates.onLoaded,
          detail: response?.data,
          bannerList: bannerList));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onChangeFormdata(DetailArticleEventOnChange event,
      Emitter<DetailArticleState> emit) async {
    // emit(state.copyWith(state: NetworkStates.onLoading));
    ContentsModel? formdata = state.formdata ?? ContentsModel();
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
    emit(state.copyWith(formdata: formdata));
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

  _setWebviewHeight(DetailArticleEventWebviewHeight event,
      Emitter<DetailArticleState> emit) async {
    emit(state.copyWith(webviewHeight: event.webviewHeight));
  }

  _addPhoto(
      DetailArticleAddPhoto event, Emitter<DetailArticleState> emit) async {
    try {
      // Pick an image
      emit(state.copyWith(state: NetworkStates.onLoading));
      if (event.type == 'thumbnail') {
        final XFile? image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 50);
        emit(state.copyWith(thumbnail: image));
      } else {
        List<XFile>? images = await _picker.pickMultiImage(imageQuality: 50);
        emit(state.copyWith(banner: images));
      }
      emit(state.copyWith(state: NetworkStates.onLoaded));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _toggleLike(
      DetailArticleOnLiked event, Emitter<DetailArticleState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading, message: 'like'));
      var response =
          await forumService.likeThread({"content_id": event.content_id});
      var detail = state.detail;
      detail?.isLiked = detail.isLiked == 0 ? 1 : 0;
      emit(state.copyWith(
          detail: detail, state: NetworkStates.onLoaded, message: 'success'));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _uploadThumbnail(ContentsModel? data) async {
    try {
      FilesModel files = FilesModel();
      files.file = File(
        state.thumbnail!.path,
      );
      files.id = data?.id;
      var response = await apiService.uploadThumbnail(files);
      debugPrint('file data ${response?.data?.id}');
    } catch (e) {
      debugPrint('ERROR FILE ${e}');
    }
  }

  _uploadFile(ContentsModel? data) async {
    try {
      FilesModel files = FilesModel();
      state.banner?.forEach((element) async {
        files.file = File(
          element.path,
        );
        files.parentId = data?.uuid;
        var response = await apiService.uploadFile(files);
        debugPrint('file data ${response?.data?.id}');
      });
    } catch (e) {
      debugPrint('ERROR FILE ${e}');
    }
  }
}
