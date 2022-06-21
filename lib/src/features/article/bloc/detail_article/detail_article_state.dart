part of 'detail_article_bloc.dart';

class DetailArticleState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final ContentsModel? detail;
  final List<FilesModel> bannerList;
  final int? activeBanner;

  const DetailArticleState({
    this.state = NetworkStates.onLoaded,
    this.message = '',
    this.bannerList = const [],
    this.activeBanner = 0,
    this.detail,
  });

  DetailArticleState copyWith({
    NetworkStates? state,
    dynamic message,
    List<FilesModel>? bannerList,
    int? activeBanner,
    ContentsModel? detail,
  }) {
    return DetailArticleState(
      state: state ?? this.state,
      message: message ?? this.message,
      bannerList: bannerList ?? this.bannerList,
      activeBanner: activeBanner ?? this.activeBanner,
      detail: detail ?? this.detail,
    );
  }

  @override
  List<Object?> get props => [state, message, bannerList, activeBanner, detail];
}
