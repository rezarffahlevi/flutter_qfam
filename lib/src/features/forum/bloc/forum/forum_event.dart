part of 'forum_bloc.dart';

abstract class ForumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForumEventInitForumList extends ForumEvent {}
class ForumEventGetForumList extends ForumEvent {}
class ForumEventGetData extends ForumEvent {
  String? uuid;
  int? parentId;
  int? forumId;

  ForumEventGetData({this.uuid, this.parentId, this.forumId});

  @override
  List<Object?> get props => [uuid, parentId, forumId];
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

  ForumEventOnChangeThread({this.threads, this.parentId, this.content, this.forumId});

  @override
  List<Object?> get props => [threads, parentId, content, forumId];
}
