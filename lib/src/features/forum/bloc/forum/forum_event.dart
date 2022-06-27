part of 'forum_bloc.dart';

abstract class ForumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForumEventInitForumList extends ForumEvent {}

class ForumEventGetForumList extends ForumEvent {}

class ForumEventGetData extends ForumEvent {
  String? uuid;
  int? id;
  int? parentId;
  int? forumId;
  int? contentId;
  int page;

  ForumEventGetData({
    this.uuid,
    this.id,
    this.parentId,
    this.forumId,
    this.contentId,
    this.page = 1,
  });

  @override
  List<Object?> get props => [uuid, id, parentId, forumId, contentId, page];
}

class ForumEventRefresh extends ForumEvent {}

class ForumEventPostThread extends ForumEvent {
  String? content;

  ForumEventPostThread({this.content});

  @override
  List<Object?> get props => [content];
}

class ForumEventInitPostThread extends ForumEvent {
  final BuildContext? context;

  ForumEventInitPostThread({this.context});

  @override
  List<Object?> get props => [context];
}

class ForumEventOnChangeThread extends ForumEvent {
  ThreadsModel? threads;
  int? parentId;
  String? content;
  int? forumId;
  int? contentId;
  int? isAnonymous;

  ForumEventOnChangeThread(
      {this.threads,
      this.parentId,
      this.content,
      this.forumId,
      this.contentId,
      this.isAnonymous});

  @override
  List<Object?> get props =>
      [threads, parentId, content, forumId, contentId, isAnonymous];
}
