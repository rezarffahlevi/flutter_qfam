part of 'detail_article_bloc.dart';

class DetailArticleState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final ContentsModel? detail;
  final ContentsModel? formdata;
  final List<FilesModel> bannerList;
  final int? activeBanner;
  final List<CategoryModel>? categoryList;
  final int page;
  final DefaultResponseModel? response;
  final XFile? thumbnail;
  final List<XFile>? banner;

  const DetailArticleState({
    this.state = NetworkStates.onLoaded,
    this.message = '',
    this.bannerList = const [],
    this.activeBanner = 0,
    this.detail,
    this.formdata,
    this.categoryList,
    this.page = 1,
    this.response,
    this.thumbnail,
    this.banner,
  });

  DetailArticleState copyWith({
    NetworkStates? state,
    dynamic message,
    List<FilesModel>? bannerList,
    int? activeBanner,
    ContentsModel? detail,
    ContentsModel? formdata,
    List<CategoryModel>? categoryList,
    int? page = 1,
    DefaultResponseModel? response,
    XFile? thumbnail,
    List<XFile>? banner,
  }) {
    return DetailArticleState(
      state: state ?? this.state,
      message: message ?? this.message,
      bannerList: bannerList ?? this.bannerList,
      activeBanner: activeBanner ?? this.activeBanner,
      detail: detail ?? this.detail,
      formdata: formdata ?? this.formdata,
      categoryList: categoryList ?? this.categoryList,
      page: page ?? this.page,
      response: response ?? this.response,
      thumbnail: thumbnail ?? this.thumbnail,
      banner: banner ?? this.banner,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        bannerList,
        activeBanner,
        detail,
        formdata,
        categoryList,
        page,
        response,
        thumbnail,
        banner,
      ];
}
