part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final BuildContext? context;
  final List<ThreadsModel>? threadsList;
  final List<ForumModel>? forumList;
  final ThreadsModel? threads;
  final int? parentId;
  final String? uuid;
  final String? content;

  const ForumState({
    this.state = NetworkStates.onLoaded,
    this.message,
    this.context,
    this.threadsList = const [],
    this.forumList = const [],
    this.threads,
    this.parentId,
    this.uuid,
    this.content,
  });

  ForumState copyWith({
    NetworkStates? state,
    dynamic message,
    BuildContext? context,
    List<ThreadsModel>? threadsList,
    List<ForumModel>? forumList,
    ThreadsModel? threads,
    int? parentId,
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
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props =>
      [state, message, context, threadsList, threads, parentId, content];
}
