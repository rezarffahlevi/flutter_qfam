part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final String? message;
  final BuildContext? context;
  final List<ThreadsModel>? threadsList;
  final List<ForumModel>? forumList;
  final ThreadsModel? threads;
  final int? forumId;
  final int? parentId;
  final int? contentId;
  final String? uuid;
  final String? content;

  const ForumState({
    this.state = NetworkStates.onLoaded,
    this.message,
    this.context,
    this.threadsList = const [],
    this.forumList = const [],
    this.threads,
    this.forumId,
    this.parentId,
    this.contentId,
    this.uuid,
    this.content,
  });

  ForumState copyWith({
    NetworkStates? state,
    String? message,
    BuildContext? context,
    List<ThreadsModel>? threadsList,
    List<ForumModel>? forumList,
    ThreadsModel? threads,
    int? parentId,
    int? forumId,
    int? contentId,
    String? uuid,
    String? content,
  }) {
    return ForumState(
      state: state ?? this.state,
      message: message ?? this.message,
      context: context ?? this.context,
      threadsList: threadsList ?? this.threadsList,
      forumList: forumList ?? this.forumList,
      threads: threads ?? this.threads,
      parentId: parentId ?? this.parentId,
      forumId: forumId ?? this.forumId,
      contentId: forumId ?? this.contentId,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props =>
      [state, message, context, threadsList, threads, forumId, parentId, contentId, content];
}
