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
class DetailArticleEventGetCategory extends DetailArticleEvent {}
class DetailArticleEventOnPost extends DetailArticleEvent {}

class DetailArticleEventSetActiveBanner extends DetailArticleEvent {
  int activeBanner;

  DetailArticleEventSetActiveBanner({this.activeBanner = 0});

  @override
  List<Object?> get props => [activeBanner];
}

class DetailArticleEventInitPost extends DetailArticleEvent {
  BuildContext? context;

  DetailArticleEventInitPost({this.context});

  @override
  List<Object?> get props => [context];
}

class DetailArticleEventOnChange extends DetailArticleEvent {
  String? title;
  String? subtitle;
  int? categoryId;
  int? isExternal;
  int? isVideo;
  String? link;
  String? content;
  String? thumbnail;
  String? status;

  DetailArticleEventOnChange({this.title, this.subtitle, this.categoryId, this.isExternal, this.isVideo, this.link, this.content, this.thumbnail, this.status});

  @override
  List<Object?> get props => [title, subtitle, categoryId, isExternal, isVideo, link, content, thumbnail, status];
}
