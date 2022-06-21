part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<ThreadsModel>? threadsList;
  final ThreadsModel? threads;
  final int? parentId;
  final String? content;

  const ForumState({
    this.state = NetworkStates.onLoaded,
    this.message = '',
    this.threadsList = const [],
    this.threads = null,
    this.parentId = null,
    this.content = null,
  });

  ForumState copyWith({
    NetworkStates? state,
    dynamic message,
    List<ThreadsModel>? threadsList,
    ThreadsModel? threads,
    int? parentId,
    String? content,
  }) {
    return ForumState(
      state: state ?? this.state,
      message: message ?? this.message,
      threadsList: threadsList ?? this.threadsList,
      threads: threads ?? this.threads,
      parentId: parentId ?? this.parentId,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props =>
      [state, message, threadsList, threads, parentId, content];
}
