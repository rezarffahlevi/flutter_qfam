part of 'forum_bloc.dart';

abstract class ForumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForumEventGetForumList extends ForumEvent {}
class ForumEventGetData extends ForumEvent {
  String? uuid;
  int? parentId;

  ForumEventGetData({this.uuid, this.parentId});

  @override
  List<Object?> get props => [uuid];
}

class ForumEventRefresh extends ForumEvent {}

class ForumEventPostThread extends ForumEvent {
  String? content;

  ForumEventPostThread({this.content});

  @override
  List<Object?> get props => [content];
}

class ForumEventInit extends ForumEvent {
  final BuildContext? context;

  ForumEventInit({this.context});

  @override
  List<Object?> get props => [context];
}

class ForumEventOnChangeThread extends ForumEvent {
  ThreadsModel? threads;
  int? parentId;
  String? content;

  ForumEventOnChangeThread({this.threads, this.parentId, this.content});

  @override
  List<Object?> get props => [threads, parentId, content];
}
