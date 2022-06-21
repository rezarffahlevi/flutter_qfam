part of 'detail_article_bloc.dart';

abstract class DetailArticleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailArticleEventGetDetail extends DetailArticleEvent {
  final String? uuid;

  DetailArticleEventGetDetail({this.uuid});

  @override
  List<Object?> get props => [uuid];
}

class DetailArticleEventRefresh extends DetailArticleEvent {}

class DetailArticleEventSetActiveBanner extends DetailArticleEvent {
  int activeBanner;

  DetailArticleEventSetActiveBanner({this.activeBanner = 0});

  @override
  List<Object?> get props => [activeBanner];
}
