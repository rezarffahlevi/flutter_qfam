part of 'detail_article_bloc.dart';

class DetailArticleState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final ContentsModel? detail;
  final ContentsModel? formdata;
  final List<FilesModel> bannerList;
  final int? activeBanner;
  final List<CategoryModel>? categoryList;

  const DetailArticleState({
    this.state = NetworkStates.onLoaded,
    this.message = '',
    this.bannerList = const [],
    this.activeBanner = 0,
    this.detail,
    this.formdata,
    this.categoryList,
  });

  DetailArticleState copyWith({
    NetworkStates? state,
    dynamic message,
    List<FilesModel>? bannerList,
    int? activeBanner,
    ContentsModel? detail,
    ContentsModel? formdata,
    List<CategoryModel>? categoryList,
  }) {
    return DetailArticleState(
      state: state ?? this.state,
      message: message ?? this.message,
      bannerList: bannerList ?? this.bannerList,
      activeBanner: activeBanner ?? this.activeBanner,
      detail: detail ?? this.detail,
      formdata: formdata ?? this.formdata,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  @override
  List<Object?> get props =>
      [state, message, bannerList, activeBanner, detail, formdata, categoryList];
}
